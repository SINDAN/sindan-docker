FROM ruby:2.3.1

ENV APP_ROOT /usr/src/sindan

WORKDIR $APP_ROOT

ENV GEM_HOME "/opt/td-agent/embedded/lib/ruby/gems/2.1.0/"
ENV GEM_PATH "/opt/td-agent/embedded/lib/ruby/gems/2.1.0/"

RUN apt-get update && \
    apt-get install -y nodejs \
                       ansible \
                       sudo \
                       git \
                       mysql-client \
                       --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8888 24224

RUN curl -L https://toolbelt.treasuredata.com/sh/install-ubuntu-xenial-td-agent2.sh | sh
COPY td-agent.conf /etc/td-agent/

RUN /opt/td-agent/embedded/bin/fluent-gem install fluent-plugin-mysql

ENTRYPOINT td-agent
#ENTRYPOINT /bin/bash
