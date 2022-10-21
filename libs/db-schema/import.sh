#!/usr/bin/env bash
set -xe

for sql_file in `ls .`; do mysql -h "$DB_HOST" -u $DB_USERNAME -p$DB_PASSWORD "$DB_DATABASE" < "$sql_file" ; done

