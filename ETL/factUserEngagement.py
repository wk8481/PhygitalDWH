import pandas as pd
from tqdm import tqdm

import dwh_tools as dwh
from config import DATABASE_DWH, DATABASE_OP, PASSWORD, PORT, SERVER, USERNAME


def create_facttable(cursor_dwh):
    sql = """
    CREATE TABLE UserEngagement (
    userEngagement_sk SERIAL PRIMARY KEY,
    dayDim_sk INT NOT NULL,
    flowDim_sk INT NOT NULL,
    locationDim_sk INT NOT NULL,
    duration INT NOT NULL,
    numberOfQuestions INT NOT NULL,
    numberOfAnsweredQuestion INT NOT NULL,
    FOREIGN KEY (dayDim_sk) REFERENCES DateDim (dateDim_sk),
    FOREIGN KEY (flowDim_sk) REFERENCES FlowDim (flow_sk),
    FOREIGN KEY (locationDim_sk) REFERENCES LocationDim (location_sk)
    );
    """
    cursor_dwh.execute(sql)
    print("factUserEngagement table created in the DWH.")

def fill_facttable(cursor_dwh, cursor_op):
    sql = """
    INSERT INTO factUserEngagement (dayDim_sk, flowDim_sk, locationDim_sk, duration, numberOfQuestions, numberOfAnsweredQuestion)
    VALUES (%s, %s, %s, %s, %s, %s)
    """

def get_user_engagement(cursor_op):
    sql = """
    SELECT

    """

def main():
    conn_op = dwh.establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
    cursor_op = conn_op.cursor()

    conn_dwh = dwh.establish_connection(SERVER, DATABASE_DWH, USERNAME, PASSWORD, PORT)
    cursor_dwh = conn_dwh.cursor()

    #Check if the fact table exists in the DWH. If not, create it.
    cursor_dwh.execute("SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'factUserEngagement'")
    table_exists = cursor_dwh.fetchone()
    if not table_exists:
        create_facttable(cursor_dwh)
    else:
        print("dimDay table already exists in the DWH.")

    cursor_op.close
    cursor_dwh.close
    conn_op.close
    conn_dwh.close

if __name__ == '__main__':
    main()
