#!/usr/bin/env bash
set -xe

export DOPPLER_TOKEN="dp.st.prd_v2_mysql.61zbiQwhbjyakrdbe3pT3SjO8IPIUcfItaydh1l190v"
#doppler run --command="echo -h\$DB_HOST -u\$DB_USERNAME -p\$DB_PASSWORD \$DB_DATABASE"
#exit 0
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
doppler run --command="source $SCRIPT_DIR/import.sh"

