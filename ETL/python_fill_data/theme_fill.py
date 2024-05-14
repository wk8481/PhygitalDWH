import random
import sys

sys.path.append("..")

from config import DATABASE_OP, PASSWORD, PORT, SERVER, USERNAME
from dwh_tools import establish_connection
from tqdm import tqdm


def random_theme_info():
    """Return a random theme info."""

    theme_info = random.choice(['Theme Info A', 'Theme Info B', 'Theme Info C', 'Theme Info D', 'Theme Info E'])
    return theme_info

def random_theme_name(amount):
    """Return a random theme name. cannot repeat the same theme name."""

    theme_name = 'Theme ' + str(amount)
    return theme_name

def get_project_id(cursor):
    sql = """
    SELECT id
    FROM public.project
    """
    cursor.execute(sql)
    result = cursor.fetchall()
    return result

def check_theme_table(cursor,  name):
    sql =  """
    SELECT name
    FROM public.theme
    WHERE name = %s;
    """
    cursor.execute(sql, (name,))
    result = cursor.fetchall()
    return result

def fill_theme_table(cursor, amount, project_id):
    sql = """
    INSERT INTO PUBLIC.theme (project_id, name, information)
    VALUES (%s, %s, %s);
    """
    cursor.execute(sql, (project_id, amount[0], amount[1]))

def random_theme(amount):
    theme_info = random_theme_info()
    theme_name = random_theme_name(amount)

    theme = [theme_name, theme_info]
    return theme


def main():
    conn = establish_connection(SERVER, DATABASE_OP, USERNAME, PASSWORD, PORT)
    cursor = conn.cursor()

#    input_amount = int(input('Enter the amount of rows to fill the project and theme tables with: '))

    project_ids = get_project_id(cursor)
    print(project_ids.__len__())

    filled_amount = 0

    with tqdm(total=project_ids.__len__()) as pbar:
        while filled_amount < project_ids.__len__():

            amount = random_theme(filled_amount)
            if check_theme_table(cursor, amount[0]) == []:
                fill_theme_table(cursor, amount, project_ids[filled_amount])
                conn.commit()

            pbar.update(1)
            filled_amount += 1

    print('amount: ', filled_amount)


    cursor.close()
    conn.close()


if __name__ == '__main__':
    main()
