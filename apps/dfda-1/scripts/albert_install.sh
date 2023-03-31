#!/usr/bin/env bash
#
# Contributors: ADD YOUR NAME HERE, Mike P. Sinn | License: Open Source Under GNU General Public License v3.0
#

cd "$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./all_functions.sh
source "$(pwd -P)/all_functions.sh" "${BASH_SOURCE[0]}"
log_message "https://albertlauncher.github.io/installing/"

curl https://build.opensuse.org/projects/home:manuelschneid3r/public_key | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
sudo wget -nv https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key -O "/etc/apt/trusted.gpg.d/home:manuelschneid3r.asc"
sudo apt update
sudo apt install -y albert wmctrl scrot locate
source $QM_API/scripts/lastpass_install.sh

git clone https://github.com/mqus/jetbrains-albert-plugin.git ${XDG_DATA_HOME:-$HOME/.local/share}/albert/org.albert.extension.python/modules/jetbrains-projects

#git clone https://github.com/bergercookie/awesome-albert-plugins.git  ~/.local/share/albert/org.albert.extension.python/modules

curl https://raw.githubusercontent.com/bergercookie/jira-albert-plugin/master/install-plugin.sh | bash
log_message "Follow jira setup here https://github.com/bergercookie/jira-albert-plugin"

log_end_of_script
