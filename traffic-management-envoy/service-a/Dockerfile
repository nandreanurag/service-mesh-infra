
FROM python:3.9-slim

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt


# Define environment variable
ENV FLASK_APP=service_a.py

CMD ["python", "servicea.py"]
