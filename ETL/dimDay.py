import dwh_tools as dwh
from config import SERVER, DATABASE_OP, DATABASE_DWH, PORT, USERNAME, PASSWORD
from tqdm import tqdm

def create_dimDay(cursor_dwh):
    sql = """
    CREATE TABLE dimDay (
    dateDim_sk SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    dayOfMonth INTEGER NOT NULL,
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
    cursor_dwh.commit()
    print("dimDay table created in the DWH.")

def main():
    conn_op = dwh.establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
    cursor_op = conn_op.cursor()

    conn_dwh = dwh.establish_connection(SERVER, DATABASE_DWH, USERNAME, PASSWORD, PORT)
    cursor_dwh = conn_dwh.cursor()

    #Check if the dimDay table exists in the DWH. If not, create it.
    cursor_dwh.execute("SELECT * FROM information_schema.tables WHERE table_name = 'dimDay'")
    table_exists = cursor_dwh.fetchone()
    if not table_exists:
        create_dimDay(cursor_dwh)
    else:
        print("dimDay table already exists in the DWH.")

    with tqdm(total=) as pbar:
        while current_date < end_date:
            #check if the date exists in the dimDay table aready

    cursor_op.close
    cursor_dwh.close
    conn_op.close
    conn_dwh.close

if __name__ == '__main__':
    main()
