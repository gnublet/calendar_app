# Setup from scratch
(Optional) Create a virtual environment
```
python -m venv .venv
```

Activate the virtual environment

On Linux:
```
source .venv/bin/activate
```

On Windows:
```
.venv\Scripts\activate.ps1
```

Install python packages
```
pip install -r requirements/base.txt
pip install -r requirements/test.txt
```

Set up a postgres database through a method of your choice (from scratch, docker, docker compose, or kubernetes)
If you want to do it from scratch, [download and it](https://www.postgresql.org/download/)

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