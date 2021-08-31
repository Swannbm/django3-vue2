
# cmd: docker build . --build-arg stage=development
# cmd : docker-compose build --build-arg stage=development
ARG stage

FROM python:3-alpine

# can be 'development' or 'production'
ENV STAGE=$stage

# add linux dependencies
RUN apk add build-base postgresql-dev gcc python3-dev musl-dev

# upgrade pip
RUN python -m pip install --upgrade pip

# install poetry
# RUN apk add --no-cache curl gcc libressl-dev musl-dev libffi-dev
ADD https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py /tmp
RUN python /tmp/get-poetry.py

ENV PATH="$PATH:/root/.poetry/bin"

# copy bash hooks
COPY bin/* ./bin
# copy backend app
COPY backend ./app

COPY poetry.lock pyproject.toml ./

RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction $(test "$stage" == production && echo "--no-dev")

WORKDIR /app

EXPOSE 8000

CMD [ "python", "manage.py", "runserver", "0.0.0.0:8000" ]
