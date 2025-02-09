from pydantic_settings import BaseSettings
from pydantic import ConfigDict

class Settings(BaseSettings):
    DATABASE_URL: str
    DATABASE_USER: str
    DATABASE_PASS: str
    DATABASE_HOST: str
    DATABASE_PORT: str
    DATABASE_NAME: str
    SECRET_KEY: str
    ALGORITHM: str
    ACCESS_TOKEN_EXPIRE_MINUTES: int
    VERSION: str

    
    model_config = ConfigDict(env_file=".env")

settings = Settings()