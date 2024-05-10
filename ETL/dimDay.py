import pandas as pd
from tqdm import tqdm

import dwh_tools as dwh
from config import DATABASE_DWH, DATABASE_OP, PASSWORD, PORT, SERVER, USERNAME

holidays_in_days_of_year = [
    303, 304, 305, 306, 307, 308, 309,  # Autumn vacation
    315,  # Armistice Day
    359, 360, 361, 362, 363, 364, 365, 1, 2, 3, 4, 5, 6, 7,  # Christmas vacation
    43, 44, 45, 46, 47, 48, 49,  # Crocus vacation
    92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105,  # Easter vacation
    122,  # Labour Day
    130, 131,  # Ascension Thursday
    183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 241, 242, 243, 244  # Summer vacation
]

def create_dimDay(cursor_dwh):
    sql = """
    CREATE TABLE dimDay (
    dateDim_sk SERIAL PRIMARY KEY,
    date TIMESTAMP NOT NULL,
    dayOfMonth INTEGER NOT NULL,
    dayOfYear INTEGER NOT NULL,
    month INTEGER NOT NULL,
    year INTEGER NOT NULL,
    quarter INTEGER NOT NULL,
    hourOfDay INTEGER NOT NULL,
    dayOfWeek INTEGER NOT NULL,
    weekOfYear INTEGER NOT NULL,
    season VARCHAR(20) NOT NULL,
    schoolHoliday BOOLEAN NOT NULL
    );
    """
    cursor_dwh.execute(sql)
    print("dimDay table created in the DWH.")

def get_flow_day(cursor_op):
    sql = """
SELECT date_trunc('day', MIN(start_time))
FROM flow    """

    cursor_op.execute(sql)
    return cursor_op.fetchone()[0]

def fill_dimDay(cursor_dwh, flow_date):
    sql = """
    INSERT INTO dimDay (date, dayOfMonth, dayOfYear, month, year, quarter, hourOfDay, dayOfWeek, weekOfYear, season, schoolHoliday)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """

    date = pd.to_datetime(flow_date)
    end_date = pd.Timestamp.now()
    records_inserted = 0

    with tqdm (total=(end_date - date).days) as pbar:
        while date <= end_date:
        #check if the date is already in the dimDay tables
            cursor_dwh.execute(f"""
            SELECT date
            FROM dimDay
            WHERE date = '{date}'
            """)
            if cursor_dwh.fetchone():
                date += pd.Timedelta(days=1)
                continue

            # extract the date information
            dayOfMonth = date.day
            dayOfYear = date.dayofyear
            month = date.month
            year = date.year
            quarter = date.quarter
            hourOfDay = date.hour
            dayOfWeek = date.dayofweek
            weekOfYear = date.week
            # Determine the season using day of the year
            if 80 <= dayOfYear <= 171:
                season = 'Spring'
            elif 172 <= dayOfYear <= 264:
                season = 'Summer'
            elif 265 <= dayOfYear <= 355:
                season = 'Autumn'
            else:
                season = 'Winter'
            # Determine if the day is a school holiday
            schoolHoliday = True if holidays_in_days_of_year.count(dayOfYear) > 0 else False

            cursor_dwh.execute(sql, (date, dayOfMonth, dayOfYear, month, year, quarter, hourOfDay, dayOfWeek, weekOfYear, season, schoolHoliday))
            records_inserted += 1
            date += pd.Timedelta(days=1)
            pbar.update(1)
        cursor_dwh.connection.commit()

    print(f"{records_inserted} records inserted into dimDay table.")



def main():
    try:

        conn_op = dwh.establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
        cursor_op = conn_op.cursor()

        conn_dwh = dwh.establish_connection(SERVER, DATABASE_DWH, USERNAME, PASSWORD, PORT)
        cursor_dwh = conn_dwh.cursor()

        #Check if the dimDay table exists in the DWH. If not, create it.
        cursor_dwh.execute("SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'dimDay'")
        table_exists = cursor_dwh.fetchone()
        if table_exists:
            create_dimDay(cursor_dwh)
        else:
            print("dimDay table already exists in the DWH.")

        flow_date = get_flow_day(cursor_op)

        fill_dimDay(cursor_dwh, flow_date)

        cursor_op.close
        cursor_dwh.close
        conn_op.close
        conn_dwh.close

    except Exception as e:
        print(e)

if __name__ == '__main__':
    main()
