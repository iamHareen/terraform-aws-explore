FROM python:3.9-slim

WORKDIR /app

COPY app/src/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY app/src/ .

EXPOSE 5001

CMD ["python", "app.py"]