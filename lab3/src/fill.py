import random
import string

import psycopg2
from psycopg2 import sql


def readConfig():
    result = {}
    file = open('../../user.ini', 'r')
    for line in file.readlines():
        splitted = line.split('=')
        result[splitted[0]] = splitted[1].replace('\n', '')
    return result


def rand_string():
    return ''.join(
        random.choice(string.ascii_letters + string.digits) for _ in
        range(random.randint(1, MAX_LEN_OF_RAND_STR)))


def fill_components_and_drinks(components_size=100, drinks_size=100, max_components_per_drink=10):
    with conn.cursor() as cursor:
        conn.autocommit = True
        for i in range(components_size):
            rand_component = rand_string()
            rand_alco = random.randint(0, 100)
            components.append((rand_component, rand_alco))

        insert_components = sql.SQL('INSERT INTO components(title, alcohol) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, components))
        )
        cursor.execute(insert_components)

        for i in range(drinks_size):
            rand_drink = rand_string()
            rand_vol = random.randint(100, 1000)
            rand_alco = random.randint(0, 100)
            drinks.append((rand_drink, rand_vol, rand_alco, drink_type[random.randint(0, len(drink_type) - 1)]))

        insert_drinks = sql.SQL('INSERT INTO drinks(title, volume, alcohol, drink_type) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, drinks))
        )
        cursor.execute(insert_drinks)

        components_drinks = []  # [component_id, drink_id, quantity]
        for drink in drinks:
            cursor.execute("select drink_id from drinks where title = '{}'".format(drink[0]))
            rand_drink_id = cursor.fetchone()
            for i in range(0, max_components_per_drink):
                cursor.execute("select component_id from components where title = '{}';".format(
                    components[random.randint(0, len(components) - 1)][0]))
                rand_component_id = cursor.fetchone()
                quantity = random.randint(0, 10)
                components_drinks.append((rand_component_id, rand_drink_id, quantity))

        insert_components_drinks = sql.SQL(
            'INSERT INTO components_drinks(component_id, drink_id, quantity) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, components_drinks))
        )
        cursor.execute(insert_components_drinks)
        print("Successfully filled components and drinks!")


def fill_places(places_size=100):
    with conn.cursor() as cursor:
        conn.autocommit = True
        for i in range(places_size):
            rand_title = rand_string()
            rand_address = rand_string()
            places.append((rand_title, rand_address))

        insert_places = sql.SQL('INSERT INTO places(title, address) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, places))
        )
        cursor.execute(insert_places)
        print("Successfully filled places!")


def fill_food(food_size=100):
    with conn.cursor() as cursor:
        conn.autocommit = True
        for i in range(food_size):
            rand_title = rand_string()
            rand_price = random.randint(1, 10000)
            food.append((rand_title, rand_price))

        insert_food = sql.SQL('INSERT INTO food(title, average_price) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, food))
        )
        cursor.execute(insert_food)
        print("Successfully filled food!")


def fill_places_food(size=100, max_food_per_place=10):
    places_food = []  # [place_id, food_id)
    records = 0
    with conn.cursor() as cursor:
        conn.autocommit = True
        for k in range(0, len(places) - 1):
            cursor.execute(
                "select place_id from places where title = '{}';".format(places[random.randint(0, len(places) - 1)][0]))
            rand_place_id = cursor.fetchone()
            for i in range(0, max_food_per_place):
                cursor.execute(
                    "select food_id from food where title = '{}'".format(food[random.randint(0, len(food) - 1)][0]))
                rand_food_id = cursor.fetchone()
                if records < size:
                    places_food.append((rand_place_id, rand_food_id))
                    records += 1

        insert_places_food = sql.SQL('INSERT INTO places_food(place_id, food_id) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, places_food))
        )
        cursor.execute(insert_places_food)
        print("Successfully filled places_food!")


def fill_places_drinks(size=100, max_drinks_per_place=10):
    places_drinks = []  # [place_id, drink_id)
    records = 0
    with conn.cursor() as cursor:
        conn.autocommit = True
        for k in range(0, len(places) - 1):
            cursor.execute(
                "select place_id from places where title = '{}';".format(places[random.randint(0, len(places) - 1)][0]))
            rand_place_id = cursor.fetchone()
            for i in range(0, max_drinks_per_place):
                cursor.execute(
                    "select drink_id from drinks where title = '{}'".format(
                        drinks[random.randint(0, len(drinks) - 1)][0]))
                rand_drink_id = cursor.fetchone()
                if records < size:
                    places_drinks.append((rand_place_id, rand_drink_id))
                    records += 1

        insert_places_drinks = sql.SQL('INSERT INTO places_drinks(place_id, drink_id) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, places_drinks))
        )
        cursor.execute(insert_places_drinks)
        print("Successfully filled places_drinks!")


def fill_discounts(size=10):
    records = 0
    discounts = []
    with conn.cursor() as cursor:
        while records < size:
            cursor.execute(
                "select place_id from places where title = '{}';".format(places[random.randint(0, len(places) - 1)][0]))
            rand_place_id = cursor.fetchone()
            rand_amount = random.random()
            rand_description = rand_string()
            discounts.append(
                (rand_place_id, drink_type[random.randint(0, len(drink_type) - 1)], rand_amount, rand_description))
            records += 1

        insert_discounts = sql.SQL(
            'INSERT INTO discounts(place_id, drink_type, amount, description) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, discounts))
        )
        cursor.execute(insert_discounts)
        print("Successfully filled discounts!")


def fill_supplies_drinks(size=10):
    supplies_drinks = []
    with conn.cursor() as cursor:
        for i in range(0, size):
            cursor.execute(
                "select place_id from places where title = '{}';".format(places[random.randint(0, len(places) - 1)][0]))
            rand_place_id = cursor.fetchone()
            rand_amount = random.randint(0, 100)
            rand_price = random.randint(0, 1000)
            cursor.execute(
                "select drink_id from drinks where title = '{}'".format(drinks[random.randint(0, len(drinks) - 1)][0]))
            rand_drink_id = cursor.fetchone()
            supplies_drinks.append((rand_place_id, rand_drink_id, rand_amount, rand_price))

        insert_supplies_drinks = sql.SQL(
            'INSERT INTO supplies_drinks(place_id, drink_id, amount, price_per_item) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, supplies_drinks))
        )
        cursor.execute(insert_supplies_drinks)
        print("Successfully filled supplies_drinks!")


def fill_supplies_food(size=10):
    supplies_food = []
    with conn.cursor() as cursor:
        for i in range(0, size):
            cursor.execute(
                "select place_id from places where title = '{}';".format(places[random.randint(0, len(places) - 1)][0]))
            rand_place_id = cursor.fetchone()
            rand_amount = random.randint(0, 100)
            rand_price = random.randint(0, 1000)
            cursor.execute(
                "select food_id from food where title = '{}'".format(food[random.randint(0, len(food) - 1)][0]))
            rand_food_id = cursor.fetchone()
            supplies_food.append((rand_place_id, rand_food_id, rand_amount, rand_price))

        insert_supplies_drinks = sql.SQL(
            'INSERT INTO supplies_food(place_id, food_id, amount, price_per_item) VALUES {}').format(
            sql.SQL(',').join(map(sql.Literal, supplies_food))
        )
        cursor.execute(insert_supplies_drinks)
        print("Successfully filled supplies_food!")


if __name__ == '__main__':
    config = readConfig()
    user = config['user']
    password = config['password']
    conn = psycopg2.connect(dbname='wine_card', user=user, password=password, host='localhost')

    # set default settings
    with conn.cursor() as cursor:
        conn.autocommit = True
        cursor.execute(open("../../lab2/src/init.sql", "r").read())
        cursor.execute(open("../../lab2/src/fill.sql", "r").read())
        cursor.execute(open("../../lab2/src/change.sql", "r").read())

        cursor.execute('SELECT unnest(enum_range(NULL::drink_type))::text;')
        drink_type = cursor.fetchall()
        drink_type = [drink_type[i][0] for i in range(len(drink_type))]

    MAX_LEN_OF_RAND_STR = 50

    components = []  # [title, alcohol]
    drinks = []  # [title, volume, alcohol, drink_type]
    food = []  # [title, average_price]
    places = []  # [title, address]

    fill_components_and_drinks()
    fill_places()
    fill_food()
    fill_places_food()
    fill_places_drinks()
    fill_discounts()
    fill_supplies_drinks()
    fill_supplies_food()
