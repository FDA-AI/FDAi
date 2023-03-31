#!/usr/bin/env bash
#
# Contributors: ADD YOUR NAME HERE, Mike P. Sinn | License: Open Source Under GNU General Public License v3.0
#

cd "$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./all_functions.sh
source "$(pwd -P)/all_functions.sh" "${BASH_SOURCE[0]}"
log_message "
Download the most recent version from
https://github.com/ActivityWatch/activitywatch/releases
and unzip to /home/$WSL_USER_NAME/.local/share
"
log_end_of_script
