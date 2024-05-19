from functools import wraps
from flask import request, Response

USERNAME = "admin"
PASSWORD = "123"


def basic_auth_required():
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            """
            A decorator function that performs basic authentication before executing the wrapped function.

            Args:
                *args: Variable length argument list.
                **kwargs: Arbitrary keyword arguments.

            Returns:
                The result of executing the wrapped function.

            Raises:
                Unauthorized: If the authentication fails.

            """
            auth = request.authorization
            if not auth or not check_auth(auth.username, auth.password, USERNAME, PASSWORD):
                return Response('Unauthorized', 401, {'WWW-Authenticate': 'Basic realm="Login Required"'})
            return func(*args, **kwargs)
        return wrapper
    return decorator

def check_auth(username, password, expected_username, expected_password):
    """
    Check if the provided username and password match the expected username and password.

    Args:
        username (str): The username to check.
        password (str): The password to check.
        expected_username (str): The expected username.
        expected_password (str): The expected password.

    Returns:
        bool: True if the username and password match the expected values, False otherwise.
    """
    return username == expected_username and password == expected_password