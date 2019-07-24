FROM ruby:2.6.3-alpine
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ENV LANG C.UTF-8
ENV BUNDLE_JOBS=4
ENV RAILS_ENV=production

WORKDIR /app

COPY sindan-visualization/. .
COPY database.yml ./config
COPY secrets.yml ./config

RUN apk add --no-cache --update \
      libxml2-dev libxslt-dev libstdc++ tzdata nodejs mariadb-connector-c ca-certificates \
 && apk add --no-cache --update --virtual .build-deps \
      build-base mariadb-dev \
 && gem install bundler --no-document \
 && bundle config build.nokogiri --use-system-libraries \
 && bundle install --without development test \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

EXPOSE 3000
