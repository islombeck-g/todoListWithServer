from flask import Flask, jsonify, request
import pymysql
from config import host, db_name, password, user

app = Flask(__name__)


# def before_request():
#     allowed_ips = ['172.20.10.5','172.20.10.1', '127.0.0.1'] # здесь можно указать IP-адреса, которым разрешен доступ
#     if request.remote_addr not in allowed_ips:
#         return jsonify({'message': 'Access denied'}), 403

@app.route('/create-user', methods=['POST'])
def create_user():
    data = request.json
    username = data['username']
    password = data['password']

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
            # insert_query = "INSERT INTO users (username, password) VALUES ('" + username + "', '" + password + "');"
            insert_query = "INSERT INTO users (username, password) VALUES ('what', 'whyyouareworking');"
            cursor.execute(insert_query, (username, password))
            connection.commit()
        response = {'message': 'User created successfully'}
        status_code = 201
    except Exception as ex:
        print(ex)
        response = {'message': 'Error creating user'}
        status_code = 500
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
    finally:
        connection.close()
    return jsonify(response), status_code

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4567)


















# @app.before_request
# def before_request():
#     allowed_ips = ['172.20.10.5','172.20.10.1', '127.0.0.1'] # здесь можно указать IP-адреса, которым разрешен доступ
#     if request.remote_addr not in allowed_ips:
#         return jsonify({'message': 'Access denied'}), 403

# @app.route('/users', methods=['POST'])
# def create_user():
#     data = request.json
#     username = data['username']
#     password = data['password']
#     try:
#         connection = pymysql.connect(
#             host=host,
#             port=3306,
#             user=user,
#             password=password,
#             database=db_name,
#             cursorclass=pymysql.cursors.DictCursor
#         )
#         with connection.cursor() as cursor:
#             insert_query = "INSERT INTO users (username, password) VALUES (%s, %s);"
#             cursor.execute(insert_query, (username, password))
#             connection.commit()
#         response = {'message': 'User created successfully'}
#         status_code = 201
#     except Exception as ex:
#         print(ex)
#         response = {'message': 'Error creating user'}
#         status_code = 500
#     return jsonify(response), status_code
# @app.route('/users/<username>', methods=['PUT'])
# def update_user(username):
#     data = request.json
#     new_password = data['password']
#     try:
#         connection = pymysql.connect(
#             host=host,
#             port=3306,
#             user=user,
#             password=password,
#             database=db_name,
#             cursorclass=pymysql.cursors.DictCursor
#         )
#         with connection.cursor() as cursor:
#             update_query = "UPDATE users SET password = %s WHERE username = %s;"
#             cursor.execute(update_query, (new_password, username))
#             connection.commit()
#         response = {'message': 'User updated successfully'}
#         status_code = 200
#     except Exception as ex:
#         print(ex)
#         response = {'message': 'Error updating user'}
#         status_code = 500
#     return jsonify(response), status_code
# @app.route('/users/<username>', methods=['DELETE'])
# def delete_user(username):
#     try:
#         connection = pymysql.connect(
#             host=host,
#             port=3306,
#             user=user,
#             password=password,
#             database=db_name,
#             cursorclass=pymysql.cursors.DictCursor
#         )
#         with connection.cursor() as cursor:
#             delete_query = "DELETE FROM users WHERE username = %s"
#             cursor.execute(delete_query, (username,))
#             connection.commit()
#         response = {'message': 'User deleted successfully'}
#         status_code = 200
#     except Exception as ex:
#         print(ex)
#         response = {'message': 'Error deleting user'}
#         status_code = 500
#     return jsonify(response), status_code
# @app.route('/users', methods=['GET'])
# def get_users():
#     try:
#         connection = pymysql.connect(
#             host=host,
#             port=3306,
#             user=user,
#             password=password,
#             database=db_name,
#             cursorclass=pymysql.cursors.DictCursor
#         )
#         with connection.cursor() as cursor:
#             select_all_rows = "SELECT * FROM users"
#             cursor.execute(select_all_rows)
#             rows = cursor.fetchall()
#             response = {'users': rows}
#             status_code = 200
#     except Exception as ex:
#         print(ex)
#         response = {'message': 'Error getting users'}
#         status_code = 500
#     return jsonify(response), status_code
#
# if __name__ == '__main__':
#     app.run()