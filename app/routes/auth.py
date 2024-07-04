from flask import Blueprint, request, jsonify
from flask_jwt_extended import create_access_token
from marshmallow import ValidationError
from werkzeug.security import generate_password_hash, check_password_hash
from app.db import get_db_connection, get_db_cursor
from flask_jwt_extended import jwt_required, get_jwt_identity, get_jwt
from app.utils import create_response
import psycopg2

bp = Blueprint('auth', __name__)

@bp.route('/register', methods=['POST'])
def register():
    try:
        data = request.json

        username = data.get('username')
        password = data.get('password')
        email = data.get('email')
        first_name = data.get('firstName')
        last_name = data.get('lastName')

        if not all([username, password, email, first_name, last_name]):
            return jsonify(create_response(False, "All fields are required")), 400

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("SELECT * FROM users WHERE username = %s", (username,))
        if cur.fetchone():
            return jsonify(create_response(False, "Username already exists")), 400

        cur.execute(
            "INSERT INTO users (username, password_hash, email, first_name, last_name) VALUES (%s, %s, %s, %s, %s) RETURNING id",
            (username, generate_password_hash(password), email, first_name, last_name)
        )
        user_id = cur.fetchone()[0]
        conn.commit()

        # Create access token
        access_token = create_access_token(identity=username,expires_delta=False)

        # Prepare user data
        user_data = {
            'id': user_id,
            'username': username,
            'email': email,
            'firstName': first_name,
            'lastName': last_name,
            'accessToken': access_token
        }

        return jsonify(create_response(True, "User registered successfully", data=user_data)), 201
    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()
@bp.route('/login', methods=['POST'])
def login():
    try:
        data = request.json
        username = data.get('username')
        password = data.get('password')

        if not all([username, password]):
            return jsonify(create_response(False, "Username and password are required")), 400

        cur = get_db_cursor()
        cur.execute("SELECT * FROM users WHERE username = %s", (username,))
        user = cur.fetchone()

        if user and check_password_hash(user['password_hash'], password):
            access_token = create_access_token(identity=username,expires_delta=False)
            user_data = {
                'id': user['id'],
                'username': user['username'],
                'email': user['email'],
                'firstName': user['first_name'], 
                'lastName': user['last_name'],   
                'accessToken': access_token       
            }
            return jsonify(create_response(True, "Login successful", data=user_data)), 200
        else:
            return jsonify(create_response(False, "Invalid username or password")), 401
    except ValidationError as e:
        return jsonify(create_response(False, "Validation error", e.messages)), 400
    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()
@bp.route('/user', methods=['GET'])
@jwt_required()
def get_user_info():
    try:
        username = get_jwt_identity()

        cur = get_db_cursor()
        cur.execute("""
            SELECT id, username, email, first_name, last_name
            FROM users
            WHERE username = %s
        """, (username,))
        user = cur.fetchone()

        if user:
            user_data = {
                'id': user['id'],
                'username': user['username'],
                'email': user['email'],
                'firstName': user['first_name'],
                'lastName': user['last_name'],
                'accessToken': request.headers.get('Authorization').split()[1]  # Get the token from the Authorization header
            }
            return jsonify(create_response(True, "User information retrieved successfully", data=user_data)), 200
        else:
            return jsonify(create_response(False, "User not found")), 404

    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()