FROM fluent/fluentd:v1.6-1
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

USER root

RUN apk add --no-cache --update --virtual .build-deps sudo build-base ruby-dev mariadb-dev \
 && sudo gem install fluent-plugin-mysql \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

COPY fluent.conf /fluentd/etc/

USER fluent
