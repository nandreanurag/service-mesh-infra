FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt


ENV FLASK_APP=service_c.py
CMD ["python", "servicec.py"]