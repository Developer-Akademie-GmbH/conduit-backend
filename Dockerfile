FROM python:3.5.2

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip \
    && pip install -r requirements.txt \
    && pip install gunicorn

EXPOSE 8000

CMD ["gunicorn", "conduit.wsgi:application", "--bind", "0.0.0.0:8000"]
