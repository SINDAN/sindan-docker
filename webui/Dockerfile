FROM ruby:latest

ENV APP_ROOT /usr/src/sindan-visualization

WORKDIR $APP_ROOT
COPY ./sindan-visualization $APP_ROOT

RUN apt-get update && \
    apt-get install -y nodejs \
                       ansible \
                       sudo \
                       git \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 80 443 3000

ENV SINDAN_VISUALIZATION_DATABASE_PASSWORD sindantest
ENV DB_USER root
ENV DB_PASSWORD sindantest
ENV DB_ADAPTER mysql2

RUN \
  echo 'gem: --no-document' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog+r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

#COPY Gemfile $APP_ROOT
#COPY Gemfile.lock $APP_ROOT

COPY database.yml $APP_ROOT/config/

CMD ["rails", "server", "-b", "0.0.0.0"]
