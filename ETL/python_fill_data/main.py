import sys

sys.path.append('..')

from dwh_tools import establish_connection


def show_tables(cursor):
    sql = """
    SELECT table_name
    FROM information_schema.tables
    WHERE table_schema = 'public';
    """
    cursor.execute(sql)
    tables = cursor.fetchall()
    count = 1
    for table in tables:
        print(count,'-' ,'{:9.20}'.format(table[0]))
        count += 1
    return tables

def main():
    connection = establish_connection()
    cursor = connection.cursor()

    print("""
    Welcome to the Operational database filling system.
    Please select an option from the following:
    1. Fill the database with random data
    2. See the data in the database
    """)

    option = input("Enter the option: ")

    if option == '1':
        print("Which table do you want to fill?")
        print(show_tables(cursor))

    elif option == '2':
        print("Which table do you want to see?")
        show_tables(cursor)
if __name__ == '__main__':
    main()
