#!/bin/bash
./cloud_sql_proxy.sh -instances=curedao:us-east4:pg-14=tcp:3306 -credential_file=cloud_sql_proxy_credentials.json
