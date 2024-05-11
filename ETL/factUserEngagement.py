import pandas as pd
from tqdm import tqdm

import dwh_tools as dwh
from config import DATABASE_DWH, DATABASE_OP, PASSWORD, PORT, SERVER, USERNAME


def create_facttable(cursor_dwh):
    sql = """
    CREATE TABLE factUserEngagement (
    userEngagement_sk SERIAL PRIMARY KEY,
    dayDim_sk INT NOT NULL,
    flowDim_sk INT NOT NULL,
    locationDim_sk INT NOT NULL,
    duration INT NOT NULL,
    numberOfQuestions INT NOT NULL,
    numberOfAnsweredQuestion INT NOT NULL,
    FOREIGN KEY (dayDim_sk) REFERENCES dimDay (dateDim_sk),
    FOREIGN KEY (flowDim_sk) REFERENCES dimFlow (flowdim_sk),
    FOREIGN KEY (locationDim_sk) REFERENCES dimLocation (locationDim_sk)
    );
    """
    cursor_dwh.execute(sql)
    print("factUserEngagement table created in the DWH.")

def get_user_engagement(cursor_op):
    sql = """
    SELECT
    DATE_TRUNC('day', f.start_time) AS flow_day,
    t.name AS theme_name,
    l.city,
    l.province,
    l.street,
    l.street_number,
    EXTRACT(EPOCH FROM (f.end_time - f.start_time)) AS duration_seconds,
    COUNT(q.id) AS total_questions,
    COUNT(a.id) AS answered_questions
FROM
    public.flow f
JOIN
    public.project p ON f.project_id = p.id
JOIN
    public.theme t ON t.project_id = p.id
JOIN
    public.installation i ON f.installation_id = i.id
JOIN
    public.location l ON i.location_id = l.id
JOIN
    public.flow_sub_themes fst ON f.id = fst.flow_id
JOIN
    public.sub_theme st ON fst.sub_themes_id = st.id
LEFT JOIN
    public.question q ON st.id = q.sub_theme_id
LEFT JOIN
    public.answer a ON st.id = a.subtheme_id
GROUP BY
    f.start_time, t.name, l.city, l.province, f.end_time, l.street, l.street_number
ORDER BY
    flow_day;"""

    cursor_op.execute(sql)
    user_engagement = cursor_op.fetchall()
    return user_engagement

def get_day_dim_sk(cursor_dwh, date):
    sql = f"""
    SELECT dateDim_sk
    FROM dimDay
    WHERE date = '{date}'
    """
    cursor_dwh.execute(sql)
    day_dim_sk = cursor_dwh.fetchone()
    return day_dim_sk

def get_flow_dim_sk(cursor_dwh, theme):
    sql = f"""
    SELECT flowDim_sk
    FROM dimFlow
    WHERE theme = '{theme}'
    """
    cursor_dwh.execute(sql)
    flow_dim_sk = cursor_dwh.fetchone()
    return flow_dim_sk

def get_location_dim_sk(cursor_dwh, city, province, street, street_number):
    sql = f"""
    SELECT locationDim_sk
    FROM dimLocation
    WHERE city = '{city}' AND province = '{province}' AND street = '{street}' AND street_number = {street_number}
    """
    cursor_dwh.execute(sql)
    location_dim_sk = cursor_dwh.fetchone()
    return location_dim_sk

def check_user_engagement(cursor_dwh, day_dim_sk, flow_dim_sk, location_dim_sk, duration, total_questions, answered_questions):
    sql = f"""
    SELECT *
    FROM factUserEngagement
    WHERE dayDim_sk = %s AND flowDim_sk = %s AND locationDim_sk = %s AND duration = %s AND numberOfQuestions = %s AND numberOfAnsweredQuestion = %s
    """
    cursor_dwh.execute(sql, (day_dim_sk, flow_dim_sk, location_dim_sk, duration, total_questions, answered_questions))
    if cursor_dwh.fetchone():
        return True
    return False

def fill_fact_table(cursor_dwh, day_dim_sk, flow_dim_sk, location_dim_sk, duration, total_questions, answered_questions):
    sql = """
    INSERT INTO UserEngagement (dayDim_sk, flowDim_sk, locationDim_sk, duration, numberOfQuestions, numberOfAnsweredQuestion)
    VALUES (%s, %s, %s, %s, %s, %s)
    """
    cursor_dwh.execute(sql, (day_dim_sk, flow_dim_sk, location_dim_sk, duration, total_questions, answered_questions))
    cursor_dwh.connection.commit()

def main():

    conn_op = dwh.establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
    cursor_op = conn_op.cursor()

    conn_dwh = dwh.establish_connection(SERVER, DATABASE_DWH, USERNAME, PASSWORD, PORT)
    cursor_dwh = conn_dwh.cursor()

    #Check if the fact table exists in the DWH. If not, create it.
    cursor_dwh.execute("SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'factUserEngagement'")
    table_exists = cursor_dwh.fetchone()
    if table_exists:
        create_facttable(cursor_dwh)
    else:
        print("factUserEngagement table already exists in the DWH.")

    user_engagement = get_user_engagement(cursor_op)
    records = 0
    with tqdm(total=len(user_engagement)) as pbar:
        for u in user_engagement:
            day_dim_sk = get_day_dim_sk(cursor_dwh, u[0])
            flow_dim_sk = get_flow_dim_sk(cursor_dwh, u[1])
            location_dim_sk = get_location_dim_sk(cursor_dwh, u[2], u[3], u[4], u[5])
            if day_dim_sk is None or flow_dim_sk is None or location_dim_sk is None:
                print('day_dim_sk', day_dim_sk)
                print('flow_dim_sk', flow_dim_sk)
                print('location_dim_sk', location_dim_sk)
            if check_user_engagement(cursor_dwh, day_dim_sk, flow_dim_sk, location_dim_sk, u[6], u[7], u[8]):
                pbar.update(1)
                continue
            fill_fact_table(cursor_dwh, day_dim_sk, flow_dim_sk, location_dim_sk, u[6], u[7], u[8])
            records += 1
            pbar.update(1)

    cursor_op.close
    cursor_dwh.close
    conn_op.close
    conn_dwh.close

if __name__ == '__main__':
    main()
