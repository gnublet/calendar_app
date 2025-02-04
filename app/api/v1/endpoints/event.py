from fastapi import APIRouter, Depends, HTTPException, status
from ....schemas import event as event_schema
from ....models import event as event_model
from ....models import user as user_model
from ....database import get_db
from sqlalchemy.orm import Session
from typing import List
from datetime import datetime
from ...utils import get_current_user

router = APIRouter()

@router.post("/", response_model=event_schema.Event)
def create_event(event: event_schema.EventCreate, user_id: int, db: Session = Depends(get_db)):
    db_event = event_model.Event(**event.dict(), user_id=user_id)
    db.add(db_event)
    db.commit()
    db.refresh(db_event)
    return db_event

@router.get("/", response_model=List[event_schema.Event])
def read_events(skip: int = 0, limit: int = 100, user_id: int = None, db: Session = Depends(get_db)):
    query = db.query(event_model.Event)
    if user_id:
        query = query.filter(event_model.Event.user_id == user_id)
    return query.offset(skip).limit(limit).all()

@router.get("/{event_id}", response_model=event_schema.Event)
def read_event(event_id: int, db: Session = Depends(get_db)):
    event = db.query(event_model.Event).filter(event_model.Event.id == event_id).first()
    if event is None:
        raise HTTPException(status_code=404, detail="Event not found")
    return event

@router.put("/{event_id}", response_model=event_schema.Event)
def update_event(
    event_id: int, 
    event_update: event_schema.EventUpdate, 
    db: Session=Depends(get_db), 
    current_user: user_model.User=Depends(get_current_user)
):
    db_event = db.query(event_model.Event).filter(event_model.Event.id == event_id).first()
    if db_event is None:
        raise HTTPException(status_code=404, detail="Event not found")

    # Check if the current user is the owner of the event
    if db_event.user_id != current_user.id:
        raise HTTPException(
            status_code=403,
            detail="Not authorized to modify this event"
        )
    
    update_data = event_update.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_event, field, value)
    
    db.commit()
    db.refresh(db_event)
    return db_event

@router.delete("/{event_id}")
def delete_event(event_id: int, db: Session = Depends(get_db)):
    event = db.query(event_model.Event).filter(event_model.Event.id == event_id).first()
    if event is None:
        raise HTTPException(status_code=404, detail="Event not found")
    db.delete(event)
    db.commit()
    return {"message": "Event deleted"}