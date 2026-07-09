FROM python:alpine

WORKDIR /app

COPY requirements_lock.txt .

RUN pip install --upgrade pip \
&& pip install --no-cache-dir -r requirements_lock.txt

COPY . .

CMD ["python", "main.py"]
