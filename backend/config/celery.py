"""
Celery config file

https://docs.celeryproject.org/en/stable/django/first-steps-with-django.html

"""
from __future__ import absolute_import
import os

from celery import Celery
from celery.schedules import crontab
from celery.utils.log import get_task_logger
from django.conf import settings


logger = get_task_logger(__name__)

# this code copied from manage.py
# set the default Django settings module for the 'celery' app.
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "config.settings")

# you change change the name here
app = Celery("config")

# read config from Django settings, the CELERY namespace would make celery
# config keys has `CELERY` prefix
app.config_from_object("django.conf:settings", namespace="CELERY")

# load tasks.py in django apps
app.autodiscover_tasks(lambda: settings.INSTALLED_APPS)


app.conf.timezone = "UTC"


# beat configuration
app.conf.beat_schedule = {
    'check_celery_is_running': {
        'task': 'config.celery.log',
        'schedule': crontab(),  # execute every minutes
    },
}


@app.task
def log():
    # start logging
    logger.info("Celery is running Superman !")
