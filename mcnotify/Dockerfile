FROM node:8.12.0-alpine

ENV APP_VERSION v0.1.0

WORKDIR /web/app

RUN set -ex \
    && apk add --no-cache curl \
    && curl -Lf https://github.com/kivy/mcnotify/archive/$APP_VERSION.tar.gz > app.tar.gz \
    && tar -xf app.tar.gz --strip-components=1 && rm app.tar.gz \
    && yarn install --ignore-engines --production \
    && apk del curl

EXPOSE 3000

CMD ["yarn", "start"]
