#!/bin/bash
/usr/bin/mysql -u $MYSQL_USER --password=$(< $MYSQL_PASSWORD_FILE) $MYSQL_DATABASE
