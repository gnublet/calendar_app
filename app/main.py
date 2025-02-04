from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from typing import List
import os
from dotenv import load_dotenv

from . import models, schemas
from .database import engine, get_db
from .api.v1.api import api_router
from .api.v1.endpoints import user as user_router

load_dotenv(override=True)
api_version = str(os.getenv("API_VERSION", "v1"))

app = FastAPI(title="Calendar API", version=api_version)

# Didn't prefix version on users router 
# since that could break the fastapi authorize button in the /docs endpoint
# TODO alternatively, we could just move the auth button, but not important
app.include_router(user_router.router, tags=["users"]) 
app.include_router(api_router, prefix=f"/{api_version}")