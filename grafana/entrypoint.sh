#!/bin/bash

env_secrets_expand(){
    if [[ -f /run/secrets/db_password ]]; then
        export GF_MYSQL_DB_PASSWORD=$(< /run/secrets/db_password)
    fi
}

env_secrets_expand
exec /run.sh

