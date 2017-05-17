FROM openjdk:8u121-jre-alpine

ENV NOCARRIER_VERSION v1.0.0

RUN set -ex \
    && apk add --no-cache bash dcron tini s6 curl \
    && mkdir /app \
    && curl -L https://github.com/twbs/no-carrier/releases/download/$NOCARRIER_VERSION/no-carrier.jar > /app/no-carrier.jar \
    && apk del curl

COPY entry.sh start.sh /

RUN set -ex \
    && chmod +x /entry.sh /start.sh

ENTRYPOINT ["/sbin/tini", "-g", "--", "/entry.sh"]
CMD ["/start.sh"]
