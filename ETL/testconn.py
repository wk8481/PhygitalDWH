import psycopg2
import dwh_tools as dwh
from config import SERVER, DATABASE_OP, DATABASE_DWH, USERNAME, PASSWORD, PORT

def main():
    conn_op = dwh.establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
    cursor_op = conn_op.cursor()

    sql = "INSERT INTO test_table (name) VALUES ('test')"

    cursor_op.execute(sql)

    conn_op.commit()

    cursor_op.close()
    conn_op.close()

if __name__ == '__main__':
    main()
