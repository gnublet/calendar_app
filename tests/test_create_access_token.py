import pytest
from jose import JWTError, jwt
from datetime import datetime, timedelta, timezone
from app.api.utils import create_access_token  # Adjust the import based on your project structure
from app.config import settings  # Assuming settings is stored in app.config

def test_create_access_token():
    data = {"sub": "test_user"}
    token = create_access_token(data)

    # Decode the token
    decoded_token = jwt.decode(token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM])

    # Check if the subject matches
    assert decoded_token["sub"] == "test_user"