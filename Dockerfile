FROM python:slim
ENV PYTHONUNBUFFERED=1

WORKDIR /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && pip install flask gunicorn \
    && rm -rf /var/lib/apt/lists/*
