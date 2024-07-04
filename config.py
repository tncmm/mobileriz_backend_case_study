import os

class Config:
    DB_HOST = os.environ.get('DB_HOST', 'localhost')
    DB_NAME = os.environ.get('DB_NAME', 'dog_adoption')
    DB_USER = os.environ.get('DB_USER', 'postgres')
    DB_PASSWORD = os.environ.get('DB_PASSWORD', '123456')
    JWT_SECRET_KEY = os.environ.get('JWT_SECRET_KEY', 'mobileriz_jwt_key')  