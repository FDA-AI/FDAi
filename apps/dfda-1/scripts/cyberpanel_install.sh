#!/usr/bin/env bash
#
# Contributors: ADD YOUR NAME HERE, Mike P. Sinn | License: Open Source Under GNU General Public License v3.0
#

cd "$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./all_functions.sh
source "$(pwd -P)/all_functions.sh" "${BASH_SOURCE[0]}"

log_in_box "https://cyberpanel.net/docs/installing-cyberpanel/"
sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh)

log_in_box "
After the successful installation you can access CyberPanel using the details below (make sure to change):
Visit:
https:<IP Address>:8090
Username: admin
Password: 1234567
"
