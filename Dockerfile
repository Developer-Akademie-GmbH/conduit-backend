# ---------- Builder ----------
FROM python:3.6-slim AS builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

RUN apt-get update && apt-get install -y build-essential

COPY requirements.txt .
RUN pip install --upgrade pip && pip install --prefix=/install -r requirements.txt


# ---------- Runtime ----------
FROM python:3.6-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

COPY --from=builder /install /usr/local
COPY . .

EXPOSE 8000

RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "conduit.wsgi:application", "--bind", "0.0.0.0:8000"]
