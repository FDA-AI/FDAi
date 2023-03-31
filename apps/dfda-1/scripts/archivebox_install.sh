#!/usr/bin/env bash
#
# Contributors: ADD YOUR NAME HERE, Mike P. Sinn | License: Open Source Under GNU General Public License v3.0
#

cd "$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./all_functions.sh
log_info "https://github.com/ArchiveBox/ArchiveBox#install-and-run-a-specific-github-branch"
docker build -t archivebox:dev https://github.com/ArchiveBox/ArchiveBox.git#dev
docker run -it -v $PWD:/data archivebox:dev init --setup
docker run -it -v $PWD:/data archivebox server

log_info "Install this extension:
https://github.com/tjhorner/archivebox-exporter"

log_end_of_script
