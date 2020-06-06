#!/bin/bash
/usr/bin/mysqldump -u $MYSQL_USER --password=$(< $MYSQL_PASSWORD_FILE) $MYSQL_DATABASE 2> /dev/null
