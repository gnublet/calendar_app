# Build stage
FROM python:3.10.12 AS builder
WORKDIR /code
COPY ./requirements/base.txt /code/base.txt
RUN pip install --no-cache-dir --upgrade -r /code/base.txt
COPY ./app /code/app

# Test stage
FROM builder AS test
WORKDIR /code
COPY ./requirements/test.txt /code/test.txt
COPY ./setup.py /code/setup.py
COPY ./tests /code/tests
COPY .env.test /code/.env
RUN pip install --no-cache-dir --upgrade -r /code/test.txt
RUN pip install -e .
CMD ["pytest", "tests"]

# prod stage
FROM builder AS prod
WORKDIR /code
CMD ["fastapi", "run", "app/main.py", "--port", "8000"]
