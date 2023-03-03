import pymysql
from config import host, db_name, password, user

from flask import Flask, jsonify, request

# app = Flask(__name__)



try:
    connection = pymysql.connect(
        host = host,
        port = 3306,
        user = user,
        password = password,
        database = db_name,
        cursorclass = pymysql.cursors.DictCursor
    )
    print("successfully connecte")
    try:
        # insert registrate
        with connection.cursor() as cursor:
            insert_query = "INSERT INTO users (username, password) VALUES ('user3', 'password3');"
            cursor.execute(insert_query)
            connection.commit()

        # update data, change password
        with connection.cursor() as cursor:
            update_query = "UPDATE users SET password = '1111111' WHERE username = 'user2';"
            cursor.execute(update_query)
            connection.commit()

        # delete user
        with connection.cursor() as cursor:
            delete_query = "DELETE FROM users WHERE id = 1"
            cursor.execute(delete_query)
            connection.commit()


        #fetch users
        with connection.cursor() as cursor:
            select_all_rows = "SELECT * FROM users"
            cursor.execute(select_all_rows)
            rows = cursor.fetchall()
            print("All___Users")
            for row in rows:
                print(row)

    finally:
        connection.close()


except Exception as ex:
    print("error in connection")
    print(ex)
