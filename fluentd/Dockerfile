FROM fluent/fluentd:v1.14
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"
LABEL org.opencontainers.image.source https://github.com/SINDAN/sindan-docker

ENV LANG C.UTF-8

USER root

# hadolint ignore=DL3018,DL3028
RUN apk add --no-cache --update mariadb-connector-c \
 && apk add --no-cache --update --virtual .build-deps \
      build-base ruby-dev mariadb-dev mariadb-connector-c \
 && gem install fluent-plugin-http-heartbeat \
 && gem install fluent-plugin-mysql \
 && gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/

USER fluent
