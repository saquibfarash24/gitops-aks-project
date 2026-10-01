FROM python:3.13-slim

WORKDIR /app

# Update Debian packages to include security fixes
RUN apt-get update \
    && apt-get upgrade -y \
    && rm -rf /var/lib/apt/lists/*

COPY app/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir --upgrade \
       setuptools \
       urllib3 \
       msgpack \
    && rm -f /usr/local/lib/python3.13/site-packages/pip/_vendor/bom.cdx.json

COPY app/ .

EXPOSE 8081

CMD ["python", "app.py"]
