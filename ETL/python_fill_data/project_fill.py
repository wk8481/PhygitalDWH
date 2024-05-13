import random
import sys

sys.path.append("..")

from config import DATABASE_OP, PASSWORD, PORT, SERVER, USERNAME
from dwh_tools import establish_connection
from tqdm import tqdm


def random_true_false(chance):
    """Return a random True or False value based on the chance given."""

    active_project_choices = [True, False]
    active_project_weight = [chance , 1 - chance]
    active_project = random.choices(active_project_choices, weights=active_project_weight)[0]
    return active_project

def random_average_time(start, end):
    """Return a random average time between two given times."""

    average_time = random.uniform(start, end)
    rounded_average_time = round(average_time, 1)
    return rounded_average_time

def random_hex_color():
    """Return a random hex color value."""

    hex_color = '#{:06x}'.format(random.randint(0, 256**3))
    return hex_color

def random_font_name():
    """Return a random font name."""

    font_name = random.choice(['Arial', 'Times New Roman', 'Courier New', 'Verdana', 'Comic Sans MS'])
    return font_name

def random_project_name():
    """Return a random project name. cannot repeat the same project name."""

    project_name = random.choice(['Project A', 'Project B', 'Project C', 'Project D', 'Project E'])
    return project_name

def random_project():
    active_or_not = random_true_false(0.8)
    time = random_average_time(1, 60)
    random_hex = random_hex_color()
    random_font = random_font_name()
    project_name = random_project_name()

    project = [active_or_not, time, random.randint(1, 30), random_hex, random_font, 'path/to/logo.', project_name]
    return project

def check_project_table(cursor, name):
    """Check if a project name already exists in the project table."""

    sql = """
    SELECT name
    FROM public.project
    WHERE name = %s;
    """
    cursor.execute(sql, (name,))
    result = cursor.fetchall()
    return result

def fill_project_table(cursor, amount):

    sql = """
    INSERT INTO public.project (active, avg_time_spent, total_participants, background_color_hex, font_name, logo_path, name)
    VALUES (%s, %s, %s, %s, %s, %s, %s);
    """

    cursor.execute(sql, (amount[0], amount[1], amount[2], amount[3], amount[4], amount[5], amount[6]))
    return cursor.execute("SELECT currval(pg_get_serial_sequence('public.project', 'id'));").fetchone()[0]

def get_project_id(cursor):
    sql = """
    SELECT id
    FROM public.project
    """
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def main():
    conn = establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
    cursor = conn.cursor()

    input_amount = int(input('Enter the amount of rows to fill the project and theme tables with: '))

    print('Filling the project and theme tables with random data...')



    cursor.close()
    conn.close()


if __name__ == '__main__':
    main()
