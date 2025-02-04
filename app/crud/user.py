from sqlalchemy.orm import Session
from ..models.user import User
from ..schemas.user import UserCreate
from passlib.context import CryptContext
from typing import Optional

# bcrypt gives us a warning: https://github.com/pyca/bcrypt/issues/684
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_user(db: Session, user_id: int):
    return db.query(User).filter(User.id == user_id).first()

def get_user_by_email(db: Session, email: str):
    return db.query(User).filter(User.email == email).first()

def create_user(db: Session, user: UserCreate):
    hashed_password = pwd_context.hash(user.password)
    db_user = User(email=user.email, hashed_password=hashed_password)
    db.add(db_user)
    db.commit()
    db.refresh(db_user)
    return db_user

def verify_password(plain_password: str, hashed_password: str):
    return pwd_context.verify(plain_password, hashed_password)

def edit_user(db: Session, user_id: int, email: Optional[str] = None, password: Optional[str] = None):
    db_user = db.query(User).filter(User.id == user_id).first()
    if not db_user:
        return None
    
    if email is not None:
        db_user.email = email
    if password is not None:
        db_user.hashed_password = pwd_context.hash(password)
    
    db.commit()
    db.refresh(db_user)
    return db_user

def delete_user(db: Session, user_id: int):
    db_user = db.query(User).filter(User.id == user_id).first()
    if not db_user:
        return False
    
    db.delete(db_user) # Maybe do a soft delete instead?
    db.commit()
    return True