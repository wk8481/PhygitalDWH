import psycopg2
from config import SERVER, DATABASE_OP, DATABASE_DWH, PASSWORD, USERNAME, PORT


def establish_connection(server=SERVER, database=DATABASE_OP, username=USERNAME, password=PASSWORD, port=PORT):
    conn = psycopg2.connect(
        host=server,
        database=database,
        user=username,
        password=password,
        port=port
    )
    return conn
