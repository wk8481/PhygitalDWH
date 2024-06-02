import psycopg2

# Database connection parameters
db_params = {
    'host': 'localhost',
    'database': 'phygital_dwh',
    'user': 'postgres',
    'password': 'admin',
    'port': 5448
}

# Output SQL file paths
insert_data_sql_file_path = 'insert_data.sql'

# Connect to the database
conn = psycopg2.connect(**db_params)
cur = conn.cursor()

# Open SQL file for writing
with open(insert_data_sql_file_path, 'w') as insert_data_sql_file:

    # Export each table data to the SQL file
    cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
    tables = cur.fetchall()

    for table in tables:
        table_name = table[0]

        # Export table data to insert_data.sql
        cur.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{table_name}'")
        columns = cur.fetchall()
        column_names = ', '.join([col[0] for col in columns])

        insert_data_sql_file.write(f"INSERT INTO {table_name} ({column_names}) VALUES\n")

        cur.copy_expert(f"COPY {table_name} TO STDOUT WITH CSV HEADER", insert_data_sql_file)
        insert_data_sql_file.write(f"\n\n")

# Close cursor and connection
cur.close()
conn.close()

print("Table data exported to SQL file:", insert_data_sql_file_path)
