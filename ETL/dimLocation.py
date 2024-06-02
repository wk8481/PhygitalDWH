from tqdm import tqdm

import dwh_tools as dwh
from config import DATABASE_DWH, DATABASE_OP, PASSWORD, PORT, SERVER, USERNAME


def create_dimLocation(cursor):
    sql = """
    CREATE TABLE dimLocation (
        locationDim_sk SERIAL PRIMARY KEY,
        city VARCHAR(255),
        street VARCHAR(255),
        street_number INT,
        province VARCHAR(255)
    )
    """
    cursor.execute(sql)
    print("dimLocation table created in the DWH.")

def get_locations(cursor):
    sql = """
    SELECT city, street, street_number, province
    FROM location
    """
    cursor.execute(sql)
    locations = cursor.fetchall()
    return locations

def fill_dimLocation(cursor, locations):
    sql = """
    INSERT INTO dimLocation (city, street, street_number, province)
    VALUES (%s, %s, %s, %s)
    """

    records_inserted = 0

    with tqdm(total=len(locations)) as pbar:
        for location in locations:
        # Check if the location already exists in the dimLocation table
            cursor.execute(f"""
                SELECT city, street, street_number, province
                FROM dimLocation
                WHERE city = '{location[0]}' AND street = '{location[1]}' AND street_number = {location[2]} AND province = '{location[3]}'
                """)
            if cursor.fetchone():
                continue

            cursor.execute(sql, (location[0], location[1], location[2], location[3]))
            records_inserted += 1
            pbar.update(1)
        cursor.connection.commit()


def main():
    try:
        conn_op = dwh.establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
        cursor_op = conn_op.cursor()

        conn_dwh = dwh.establish_connection(SERVER, DATABASE_DWH, USERNAME, PASSWORD, PORT)
        cursor_dwh = conn_dwh.cursor()

        #Check if the dimLocation table exists in the DWH. If not, create it.
        cursor_dwh.execute("SELECT COUNT(*) FROM information_schema.tables WHERE table_name = 'dimLocation'")
        table_exists = cursor_dwh.fetchone()
        if table_exists:
            create_dimLocation(cursor_dwh)
        else:
            print("dimLocation table already exists in the DWH.")

        locations = get_locations(cursor_op)

        fill_dimLocation(cursor_dwh, locations)

        cursor_op.close
        cursor_dwh.close
        conn_op.close
        conn_dwh.close

    except Exception as e:
        print("Error:", e)



if __name__ == "__main__":
    main()
