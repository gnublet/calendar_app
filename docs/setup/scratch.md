# Setup from scratch
(Optional) Create a virtual environment
```
python -m venv .venv
```
Install python packages
```
pip install -r requirements/base.txt
pip install -r requirements/test.txt
```

Set up a postgres database through a method of your choice
Create alembic environment
```
alembic init alembic
```
Start migrations
```
alembic upgrade head
```
To run:
```
fastapi run app/main.py --port 8000
```


For tests to work, we create a setup.py file and install in development mode:
```
pip install -e .
```
then run 
```
pytest -v tests
```