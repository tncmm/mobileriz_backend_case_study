def create_response(succeeded, message, error=None, data=None):
    response = {
        "succeeded": succeeded,
        "message": message,
        "error": error,
        "data": data
    }
    return response