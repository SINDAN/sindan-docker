FROM fluent/fluentd:v1.6-1
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ENV LANG C.UTF-8

USER root

RUN apk add --no-cache --update --virtual .build-deps \
      build-base ruby-dev mariadb-dev \
 && gem install fluent-plugin-mysql \
 && gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/

USER fluent
