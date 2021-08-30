FROM python:3.9.6-alpine3.14

# upgrade pip
RUN python -m pip install --upgrade pip

# copy bash hooks
COPY bin/* ./bin

# copy backend app
COPY backend ./app

COPY poetry.lock pyproject.toml ./
RUN poetry install --no-interaction --no-dev

WORKDIR /app

# collect all static
RUN python manage.py collectstatic

EXPOSE 8000

CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]
