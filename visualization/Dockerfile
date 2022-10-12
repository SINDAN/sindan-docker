# syntax = docker/dockerfile:experimental
FROM ruby:3.1.2-alpine as builder
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ARG BUILDTIME_RAILS_SECRETKEY_FILE
ENV RAILS_SECRETKEY_FILE=$BUILDTIME_RAILS_SECRETKEY_FILE

ARG BUILDTIME_DB_PASSWORD_FILE
ENV DB_PASSWORD_FILE=$BUILDTIME_DB_PASSWORD_FILE

ENV BUNDLE_JOBS=4
ENV RAILS_ENV=production

WORKDIR /app

COPY sindan-visualization/. .
COPY database.yml config
COPY secrets.yml config
COPY seeds.rb db
COPY bundle-install.sh .

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
      yarn \
 && gem install bundler --no-document \
 && bundle config build.nokogiri --use-system-libraries \
 && bash bundle-install.sh \
 && yarn install

# hadolint ignore=SC2215
RUN --mount=type=secret,id=rails_secret,target=/run/secrets/rails_secret_key_base,required \
    --mount=type=secret,id=db_pass,target=/run/secrets/db_password,required \
    bundle exec rails assets:precompile

FROM ruby:3.1.2-alpine as production
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"
LABEL org.opencontainers.image.source https://github.com/SINDAN/sindan-docker

ENV LANG C.UTF-8
ENV BUNDLE_JOBS=4
ENV TZ=Asia/Tokyo
ENV RAILS_ENV=production
ENV RAILS_SERVE_STATIC_FILES=true

WORKDIR /app

COPY sindan-visualization/. .
COPY database.yml config
COPY secrets.yml config
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
