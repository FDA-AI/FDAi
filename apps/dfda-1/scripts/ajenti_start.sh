#!/usr/bin/env bash
#
# Contributors: ADD YOUR NAME HERE, Mike P. Sinn | License: Open Source Under GNU General Public License v3.0
#

cd "$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./all_functions.sh
source "$(pwd -P)/all_functions.sh" "${BASH_SOURCE[0]}"

log_info "Ajenti won't start with the normal commands on WSL"
# https://docs.ajenti.org/en/latest/man/run.html
/usr/local/bin/ajenti-panel --dev
