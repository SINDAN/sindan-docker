#!/bin/sh

# Usage:
# $ ./bin/backup-db.sh

dbname=sindan_production
dbuser=sindan
filename=backup-${dbname}-`date +%Y%m%d%H%M%S`.sql

echo "`date +%Y/%m/%d\ %H:%M:%S`: backup db"

mysqldump -u $dbuser -p $dbname | gzip > ~/backup/${filename}.gz
