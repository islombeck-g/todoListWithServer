from flask import Flask, jsonify, request
import pymysql

host = "127.0.0.1"
user = "newUser"
password = "someChanges123"
db_name = "myapp"
app = Flask(__name__)

@app.route('/add_data', methods=['POST'])
def add_data():
    data = request.json
    name = data['username']
    passw = data['password']

    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            select_user = "SELECT * FROM users WHERE username = %s AND password = %s"
            cursor.execute(select_user, (name, passw))
            usr = cursor.fetchone()
            if not usr:
                response = {'message': 'Invalid username or password'}
                status_code = 401
            else:
                insert_file = "INSERT INTO files (user_id, taskName, date, priority, tags, notes) VALUES (%s, %s, %s, %s, %s, %s)"
                cursor.execute(insert_file, (usr['id'], data['taskName'], data['date'], data['priority'], data['tags'], data['notes']))
                connection.commit()
                response = {'message': 'Data added successfully'}
                status_code = 200
    except Exception as ex:
        print(ex)
        response = {'message': 'Error adding data'}
        status_code = 500
    finally:
        connection.close()

    return jsonify(response), status_code
@app.route('/user', methods=['POST'])
def Login_user():
    data = request.json
    name = data['username']
    passw = data['password']
    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            select_query = "SELECT * FROM users WHERE username = '" + name + "' AND password = '" + passw + "';"
            cursor.execute(select_query)
            if cursor.fetchone() is not None:
                response = {'message': 'User with this username already exists'}
                status_code = 409  # Код HTTP 409 Conflict возвращается, если ресурс уже существует
            else:
                response = {'message': 'User with this username not find'}
                status_code = 404  # Код HTTP 404 Запрашиваемый ресурс не найден на сервере
    except Exception as ex:
        print(ex)
        response = {'message': 'Error Login user'}
        status_code = 500  # Код HTTP 500 Internal Server Error возвращается, если произошла внутренняя ошибка сервера
    return jsonify(response), status_code
@app.route('/create-user', methods=['POST'])
def create_user():
    data = request.json
    name = data['username']
    passw = data['password']
    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )

        with connection.cursor() as cursor:
            select_query = "SELECT * FROM users WHERE username = '" + name + "';"
            cursor.execute(select_query)

            # Проверяем, существует ли пользователь с таким же именем
            if cursor.fetchone() is not None:
                response = {'message': 'User with this username already exists'}
                status_code = 409  # Код HTTP 409 Conflict возвращается, если ресурс уже существует
            else:
                insert_query = "INSERT INTO users (username, password) VALUES ('" + name + "', '" + passw + "');"
                cursor.execute(insert_query)
                connection.commit()
                response = {'message': 'User created successfully'}
                status_code = 201  # Код HTTP 201 Created возвращается, если ресурс был создан успешно

    except Exception as ex:
        print(ex)
        response = {'message': 'Error creating user'}
        status_code = 500  # Код HTTP 500 Internal Server Error возвращается, если произошла внутренняя ошибка сервера

    return jsonify(response), status_code

@app.route('/data', methods=['POST'])
def get_data():
    data = request.json
    name = data['username']
    passw = data['password']
    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            # find the user with the given username and password
            select_user = "SELECT * FROM users WHERE username = %s AND password = %s"
            cursor.execute(select_user, (name, passw))
            usr = cursor.fetchone()

            if not usr:
                # if user not found, return an error response
                response = {'message': 'Invalid username or password'}
                status_code = 401
            else:
                # find the files with the same user_id as the found user
                select_files = "SELECT * FROM files WHERE user_id = %s"
                cursor.execute(select_files, (usr['id'],))
                files = cursor.fetchall()
                response = {'files': files}
                status_code = 200
    except Exception as ex:
        print(ex)
        response = {'message': 'Error getting files'}
        status_code = 500
    finally:
        connection.close()

    return jsonify(response), status_code

@app.route('/users/<username>', methods=['DELETE'])
def delete_user(username):
    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            delete_query = "DELETE FROM users WHERE username = %s"
            cursor.execute(delete_query, (username,))
            connection.commit()
        response = {'message': 'User deleted successfully'}
        status_code = 200
    except Exception as ex:
        print(ex)
        response = {'message': 'Error deleting user'}
        status_code = 500
    return jsonify(response), status_code

@app.route('/users', methods=['GET'])
def get_users():
    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
        print("good")
        # print(request.headers)
        with connection.cursor() as cursor:
            select_all_rows = "SELECT * FROM users"
            cursor.execute(select_all_rows)
            rows = cursor.fetchall()
            response = {'users': rows}
            status_code = 200
    except Exception as ex:
        print(ex)
        response = {'message': 'Error getting users'}
        status_code = 500
    # finally:
    #     connection.close()
    return jsonify(response), status_code

@app.route('/users/<username>', methods=['PUT'])
def update_user(username):
    data = request.json
    new_password = data['password']
    try:
        connection = pymysql.connect(
            host=host,
            port=3306,
            user=user,
            password=password,
            database=db_name,
            cursorclass=pymysql.cursors.DictCursor
        )
        with connection.cursor() as cursor:
            update_query = "UPDATE users SET password = %s WHERE username = %s;"
            cursor.execute(update_query, (new_password, username))
            connection.commit()
        response = {'message': 'User updated successfully'}
        status_code = 200
    except Exception as ex:
        print(ex)
        response = {'message': 'Error updating user'}
        status_code = 500
    return jsonify(response), status_code


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4568)



