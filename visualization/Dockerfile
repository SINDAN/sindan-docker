FROM ruby:2.6.3-alpine as builder
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ENV BUNDLE_JOBS=4
ENV RAILS_ENV=production

WORKDIR /app

COPY sindan-visualization/Gemfile .
COPY sindan-visualization/Gemfile.lock .
COPY sindan-visualization/Rakefile .
COPY sindan-visualization/app/assets app/assets
COPY sindan-visualization/bin bin
COPY sindan-visualization/config config
COPY secrets.yml config

RUN apk add --no-cache --update \
      build-base  alpine-sdk tzdata shadow sudo ca-certificates \
      busybox-suid mariadb-dev mariadb-connector-c-dev \
      libxml2-dev libxslt-dev libstdc++ nodejs \
 && gem install bundler --no-document \
 && bundle config build.nokogiri --use-system-libraries \
 && bundle install --without development test --path vendor/bundle
RUN --mount=type=secret,id=keybase,dst=/run/secrets/rails_secret_key_base \
    bundle exec rails assets:precompile

FROM ruby:2.6.3-alpine as production
LABEL maintainer "mi2428 <tmiya@protonmail.ch>"

ENV LANG C.UTF-8
ENV BUNDLE_JOBS=4
ENV TZ=Asia/Tokyo
ENV RAILS_ENV=production

WORKDIR /app

COPY sindan-visualization/. .
COPY database.yml config
COPY secrets.yml config

RUN apk add --no-cache --update \
      libxml2-dev libxslt-dev libstdc++ tzdata \
      mariadb-connector-c ca-certificates

COPY --from=builder /app/vendor/bundle vendor/bundle
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /app/public/assets /app/public/assets

EXPOSE 3000
