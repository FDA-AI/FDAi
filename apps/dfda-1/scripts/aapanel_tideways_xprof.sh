#!/usr/bin/env bash
#
# Contributors: ADD YOUR NAME HERE, Mike P. Sinn | License: Open Source Under GNU General Public License v3.0
#

# shellcheck disable=SC2046
cd "$(dirname "${BASH_SOURCE[0]}")"
# shellcheck source=./all_functions.sh
source "$(pwd -P)/all_functions.sh" "${BASH_SOURCE[0]}"
apt_update_if_necessary
#sudo apt-get install php$PHP_VERSION-dev -y
log_info "https://guides.wp-bullet.com/using-free-tideways-xhprof-xhgui-php-7-x-for-wordpress-code-profiling/"
log_info "https://forum.aapanel.com/d/667-install-additional-php-extensions/5"
cd /tmp
git clone https://github.com/tideways/php-xhprof-extension
cd php-xhprof-extension
/www/server/php/74/bin/phpize
./configure --with-php-config=/www/server/php/74/bin/php-config
make
sudo make install

log_info '
Modify
/www/server/php/74/etc/php.ini
AND
/www/server/php/74/etc/php-cli.ini

and add:

[tideways-xhprof-7.4]
extension=/www/server/php/74/lib/php/extensions/no-debug-non-zts-20190902/tideways_xhprof.so

'
log_end_of_script
