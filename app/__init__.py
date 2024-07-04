from flask import Flask
from flask_jwt_extended import JWTManager
from config import Config

jwt = JWTManager()

def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    jwt.init_app(app)

    from app.routes import auth, dogs, favorites
    app.register_blueprint(auth.bp)
    app.register_blueprint(dogs.bp)
    app.register_blueprint(favorites.bp)

    return app