#!/bin/sh

# mysql
sudo docker build -t mysql mysql
sudo docker build -t fluentd fluentd
sudo docker build -t webui webui
