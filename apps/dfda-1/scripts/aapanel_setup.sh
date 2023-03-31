#!/usr/bin/env bash
#
# Contributors: ADD YOUR NAME HERE, Mike P. Sinn | License: Open Source Under GNU General Public License v3.0
#

cd "$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./all_functions.sh
source "$(pwd -P)/all_functions.sh" "${BASH_SOURCE[0]}"

cd /www/server/panel && python tools.py root $PW
cd /www/server/panel && python tools.py panel $PW
aapanel_nginx_config
ln -s /usr/bin/nodejs /usr/bin/node
log_end_of_script
