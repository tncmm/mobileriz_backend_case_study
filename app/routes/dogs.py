from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required
from app.db import get_db_cursor
from app.utils import create_response
import psycopg2

bp = Blueprint('dogs', __name__)

@bp.route('/dogs', methods=['GET'])
def get_dogs():
    try:
        breed = request.args.get('breed')
        age = request.args.get('age')
        size = request.args.get('size')

        query = "SELECT * FROM dogs WHERE 1=1"
        params = []

        if breed:
            query += " AND breedId = (SELECT id FROM breeds WHERE name = %s)"
            params.append(breed)
        if age:
            query += " AND age = %s"
            params.append(age)
        if size:
            query += " AND size = %s"
            params.append(size)

        cur = get_db_cursor()
        cur.execute(query, tuple(params))
        dogs = cur.fetchall()

        return jsonify(create_response(True, "Dogs retrieved successfully", data=dogs))

    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()

@bp.route('/dogs/<int:id>', methods=['GET'])
def get_dog(id):
    try:
        cur = get_db_cursor()
        cur.execute("SELECT * FROM dogs WHERE id = %s", (id,))
        dog = cur.fetchone()

        if dog:
            return jsonify(create_response(True, "Dog retrieved successfully", data=dog))
        else:
            return jsonify(create_response(False, "Dog not found")), 404

    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()

@bp.route('/search', methods=['GET'])
def search_dogs():
    try:
        keyword = request.args.get('keyword', '')
        
        cur = get_db_cursor()
        cur.execute("SELECT * FROM dogs WHERE name ILIKE %s OR description ILIKE %s", 
                    (f'%{keyword}%', f'%{keyword}%'))
        dogs = cur.fetchall()

        return jsonify(create_response(True, "Search completed successfully", data=dogs))

    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()
@bp.route('/breeds', methods=['GET'])
@jwt_required()
def get_breeds():
    try:

        cur = get_db_cursor()
        cur.execute("SELECT * FROM breeds" )
        breeds = cur.fetchall()

        if breeds:
            return jsonify(create_response(True, "Breeds retrieved successfully", data=breeds)), 200
        else:
            return jsonify(create_response(False, "Breeds not found")), 404

    except psycopg2.Error as e:
        return jsonify(create_response(False, "Database error", str(e))), 500
    except Exception as e:
        return jsonify(create_response(False, "An error occurred", str(e))), 500
    finally:
        if cur:
            cur.close()