#!/bin/sh

# mysql
sudo docker start mysql

sleep 15

# td-agent
sudo docker start fluentd

# webui
sudo docker start webui
