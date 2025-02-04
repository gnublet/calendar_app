from pydantic import BaseModel, ConfigDict
from datetime import datetime
from typing import Optional

class EventBase(BaseModel):
    title: str
    description: Optional[str] = None
    start_time: datetime
    end_time: datetime

class EventCreate(EventBase):
    pass

# all fields should be optional
class EventUpdate(BaseModel):
    title: Optional[str] = None
    description: Optional[str] = None
    start_time: Optional[datetime] = None
    end_time: Optional[datetime] = None

# Creating an event shouldn't require an id as it should be auto generated
class Event(EventBase):
    id: int
    user_id: int

    # class Config:
    #     from_attributes = True
    model_config = ConfigDict(from_attributes=True)