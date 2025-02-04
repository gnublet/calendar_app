

## Quick local setup (without docker)
(Optional) Create a virtual environment
```
python -m venv .venv
```


Install python packages
```
pip install requirements.txt
```

Create alembic environment
```
alembic init alembic
```


```
alembic upgrade
```

```
alembic downgrade -1
```

To run:
```
uvicorn app.main:app --reload
```


For tests to work, we create a setup.py file and installin development mode:
```
pip install -e .
```