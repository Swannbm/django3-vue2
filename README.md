# django3-vue2

It's a template to bootstrap new fullstack project.

## Backend

Works with Python 3.9, package handled with Poetry (all dependencies are described in pyproject.toml file).

Powered by Django 3+ and Django RestFramework 3+.

Use Postresql for database.

Fully compatible with container deployment:
- Django-storage (default configuration for AWS S3)
- Anymail (default configuration for Mailjet)

12-factors settings with django-environ (see .env-example)

Celery ready for asynchronous tasks with Redis.

Backend configurations lie in "config" folder.

Authentification through JWT with djangorestframework-jwt.

Custom User model.

### Debug configuration for VSC

Below, a few configuration for Visual Studio Code to ease debuging:

Launch Django:
```
{
    "name": "Django",
    "type": "python",
    "request": "launch",
    "program": "${workspaceFolder}/manage.py",
    "args": [
        "runserver"
    ],
    "django": true,
    "justMyCode": false
}
```

Launch a management command (required to display the file in the editor prior to push debug):
```
{
    "name": "Mgt cmd",
    "type": "python",
    "request": "launch",
    "program": "${workspaceFolder}/manage.py",
    "args": [
        "${fileBasenameNoExtension}",
        "public_data.models.CommunesSybarval"
    ],
    "justMyCode": false
}
```
Launch Celery worker in debug mode:
```
{
    "name": "Celery: worker",
    "type": "python",
    "request": "launch",
    "module": "celery",
    "console": "integratedTerminal",
    "args": [
        "-A",
        "config.celery.app",
        "worker",
        "-l",
        "info",
        "-P",
        "solo",
    ]
}
```

## Frontend

Fully integrated with Django, entry point of the app "index.html" is a django template.

Development ready with "webpack --watch" configured.

Authentification already plugged with Axios (access and refresh token).

## Deployment

Leverage Gunicorn and use specific start bash file to keep database up to date.

Docker-compose for local development

## How to finalize setup

Find all `!!TODO!!` tag in code and do what it says.
