#!/bin/bash

template="grafana/provisioning/datasources/datasources.yml.template"
target="grafana/provisioning/datasources/datasources.yml"
secret_file=".secrets/db_password.txt"

if [ ! -f "$secret_file" ] ; then
    echo "ERROR: no such file, $secret_file"
    exit 1
fi
secret=$(cat $secret_file)

if [ -z "$secret" ] ; then
    echo "ERROR: zero length password.  check $secret_file."
    exit 1
fi

if [ ! -f "$template" ] ; then
    echo "ERROR: no such file, $template"
    exit 1
fi

if [ -f "$target" ] ; then
    echo "ERROR: $target has already existed.  please consider to delete it first."
    exit 1
fi

sed -e "s/%%__DB_PWD__%%/${secret}/" < $template > $target
echo "$target has been created."
