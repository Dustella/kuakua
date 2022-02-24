FROM python:3.9-slim

COPY requirements.txt .

RUN apt-get update -qq \
    && apt-get install --no-install-recommends --yes \
        build-essential \
    && rm -rf /var/lib/apt/lists/* \
    && python3 -m pip install -r requirements.txt --no-cache-dir \
    && apt-get autoremove --purge --yes \
        build-essential 
        
COPY . .

CMD ["gunicorn", "server:app", "-c", "./gunicorn.conf.py"]