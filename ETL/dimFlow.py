import dwh_tools as dwh
import pandas as pd
from config import DATABASE_DWH, DATABASE_OP, PASSWORD, PORT, SERVER, USERNAME
from tqdm import tqdm


def create_dimFlow(cursor_dwh):
    sql = """
    CREATE TABLE create_dimFlow
    flowDim_sk SERIAL PRIMARY KEY,
    theme VARCHAR(255)
    """
    cursor_dwh.execute(sql)
    print("dimFlow table created in the DWH.")

def get_theme_from_flows_project(cursor_op):
    sql = """"
    SELECT theme
    FROM theme t
    JOIN project_id p ON t.project_id = p.project_id
    """

    cursor_op.execute(sql)
    theme = cursor_op.fetchall()
    return theme

def fill_dimFlow(cursor_dwh, theme):
    sql = """
    INSERT INTO dimFlow (theme)
    VALUES (%s)
    """

    records_inserted = 0

    with tqdm (total=len(theme)) as pbar:
        for t in theme:
            # check if the theme already exists in the dimFlow table
            cursor_dwh.execute(f"""
            SELECT theme
            FROM dimFlow
            WHERE theme = '{t}'
            """)
            if cursor_dwh.fetchone():
                t += pd.Timedelta(days=1)
                continue
            cursor_dwh.execute(sql, t)
            records_inserted += 1
            pbar.update(1)
        cursor_dwh.connection.commit()


def main():
    conn_op = dwh.establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
    cursor_op = conn_op.cursor()

    conn_dwh = dwh.establish_connection(SERVER, DATABASE_DWH, USERNAME, PASSWORD, PORT)
    cursor_dwh = conn_dwh.cursor()

    cursor_dwh.execute("SELECT * FROM information_schema.tables WHERE table_name = 'dimFlow'")
    table_exists = cursor_dwh.fetchone()
    if not table_exists:
        create_dimFlow(cursor_dwh)
    else:
        print("dimFlow table already exists in the DWH.")

    theme = get_theme_from_flows_project(cursor_op)

    fill_dimFlow(cursor_dwh, theme)

    cursor_op.close
    cursor_dwh.close
    conn_op.close
    conn_dwh.close

if __name__ == '__main__':
    main()
