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
create_table_sql_file_path = 'create_tables.sql'
insert_data_sql_file_path = 'insert_data.sql'

# Connect to the database
conn = psycopg2.connect(**db_params)
cur = conn.cursor()

# Open SQL files for writing
with open(create_table_sql_file_path, 'w') as create_table_sql_file, \
        open(insert_data_sql_file_path, 'w') as insert_data_sql_file:

    # Export each table to the SQL files
    cur.execute("SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'")
    tables = cur.fetchall()

    for table in tables:
        table_name = table[0]

        # Export table schema to create_tables.sql
        cur.execute(f"SELECT table_schema FROM information_schema.tables WHERE table_name = '{table_name}'")
        schema_query = cur.fetchone()
        schema = schema_query[0]
        create_table_query = f"CREATE TABLE IF NOT EXISTS {schema}.{table_name} AS SELECT * FROM {schema}.{table_name} WHERE 1=0;"
        create_table_sql_file.write(create_table_query)

        # Export table data to insert_data.sql
        cur.copy_expert(f"COPY {schema}.{table_name} TO STDOUT WITH CSV HEADER", insert_data_sql_file)
        insert_data_sql_file.write('\n\n')

# Close cursor and connection
cur.close()
conn.close()

print("Database exported to SQL files:", create_table_sql_file_path, "and", insert_data_sql_file_path)
