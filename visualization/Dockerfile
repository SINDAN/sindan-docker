# syntax = docker/dockerfile:experimental
FROM ruby:3.4.7-alpine as builder
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ARG BUILDTIME_DB_PASSWORD_FILE
ENV DB_PASSWORD_FILE=$BUILDTIME_DB_PASSWORD_FILE

ENV BUNDLE_JOBS=4
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_WITHOUT="development test"

WORKDIR /app

COPY sindan-visualization/. .
COPY database.dummy.yml config/database.yml
COPY seeds.rb db

# hadolint ignore=DL3018,DL3028
RUN apk add --no-cache --update \
      alpine-sdk \
      bash \
      build-base \
      busybox-suid \
      ca-certificates \
      libstdc++ \
      libxml2-dev \
      libxslt-dev \
      mariadb-connector-c-dev \
      mariadb-dev \
      nodejs \
      shadow \
      sudo \
      tzdata \
      yaml-dev
RUN bundle config set force_ruby_platform true
RUN bundle install
RUN npm install

# hadolint ignore=SC2215
RUN --mount=type=secret,id=db_password,target=/run/secrets/db_password
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rails assets:precompile

FROM ruby:3.4.7-alpine as production
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"
LABEL org.opencontainers.image.source https://github.com/SINDAN/sindan-docker

ENV LANG C.UTF-8
ENV BUNDLE_JOBS=4
ENV TZ=Asia/Tokyo
ENV RAILS_ENV=production \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_WITHOUT="development test"
ENV RAILS_LOG_LEVEL=debug

WORKDIR /app

COPY sindan-visualization/. .
COPY database.yml config
COPY seeds.rb db

# hadolint ignore=DL3018,DL3028
RUN apk add --no-cache --update \
      ca-certificates \
      libstdc++ \
      libxml2-dev \
      libxslt-dev \
      mariadb-connector-c \
      tzdata

COPY --from=builder /app/vendor/bundle /app/vendor/bundle
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/public/assets /app/public/assets
COPY --from=builder /app/app/assets/builds /app/app/assets/builds

EXPOSE 3000
