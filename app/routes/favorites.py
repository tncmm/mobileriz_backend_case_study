from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app.db import get_db_connection, get_db_cursor
from app.utils import create_response
import psycopg2

bp = Blueprint('favorites', __name__)

@bp.route('/favorites', methods=['POST'])
@jwt_required()
def add_favorite():
    try:
        username = get_jwt_identity()
        dog_id = request.json.get('dog_id')

        if not dog_id:
            return jsonify(create_response(False, "Dog ID is required")), 400

        conn = get_db_connection()
        cur = conn.cursor()

        cur.execute("SELECT id FROM users WHERE username = %s", (username,))
        user = cur.fetchone()
        if not user:
            return jsonify(create_response(False, "User not found")), 404
        user_id = user[0]
        print(user_id)

        cur.execute("SELECT * FROM favorites WHERE userid = %s AND dogid = %s", (user_id, dog_id))
        if cur.fetchone():
            return jsonify(create_response(True, "Dog already in favorites")), 200

        cur.execute("INSERT INTO favorites (userid, dogid) VALUES (%s, %s)", (user_id, dog_id))
        conn.commit()

        return jsonify(create_response(True, "Dog added to favorites")), 201

    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

@bp.route('/favorites', methods=['GET'])
@jwt_required()
def get_favorites():
    try:
        username = get_jwt_identity()

        cur = get_db_cursor()
        cur.execute("""
            SELECT d.* FROM dogs d
            JOIN favorites f ON d.id = f.dogid
            JOIN users u ON f.userid = u.id
            WHERE u.username = %s
        """, (username,))
        favorite_dogs = cur.fetchall()

        return jsonify(create_response(True, "Favorites retrieved successfully", data=favorite_dogs))

    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()