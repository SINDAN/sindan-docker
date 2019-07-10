#!/bin/sh

# mysql
sudo docker build -t mysql mysql
sudo docker build -t fluentd fluentd
sudo docker build -t webui webui

# mysql
sudo docker run --name mysql -e MYSQL_ROOT_PASSWORD=sindantest -d mysql

sleep 15

# td-agent
sudo docker run --name fluentd --link mysql:mysql -p 8888:8888 -p 24224:24224 -d fluentd

# webui
sudo docker run --name webui --link mysql:mysql -p 3000:3000 -d webui

# create initial db
sudo docker exec webui bundle exec rake db:create
sudo docker exec webui bundle exec rake db:migrate
sudo docker exec webui bundle exec rake db:seed

sudo docker stop webui
sudo docker stop fluentd
sudo docker stop mysql
