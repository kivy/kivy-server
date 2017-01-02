FROM python:2.7-alpine

COPY requirements.txt /

RUN set -ex \
    && apk add --no-cache curl tini \
    && pip install --no-cache-dir -r requirements.txt \
    && mkdir kgb \
    && curl -L https://raw.githubusercontent.com/matham/kgb2/master/main.py > /kgb/main.py \
    && apk del curl

EXPOSE 5000

ENTRYPOINT ["/sbin/tini", "-g", "--"]
CMD ["python", "/kgb/main.py"]
