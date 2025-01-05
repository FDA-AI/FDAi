#!/bin/bash
set -e

echo "------ Start test deployment tasks ------"

# Check if we're in the correct directory
echo '------ Checking mount point ------'
if [ ! -f "/var/www/html/composer.json" ]; then
    echo "Error: Project directory not mounted correctly"
    exit 1
fi

echo '------ Debugging: List current directory contents ------'
ls -la /var/www/html

echo '------ Creating directory structure ------'
mkdir -p storage/app/public \
    storage/framework/cache \
    storage/framework/sessions \
    storage/framework/testing \
    storage/framework/views \
    storage/logs \
    bootstrap/cache

echo '------ Set permissions on storage and bootstrap/cache folder  ------'
# Create directories if they don't exist and set permissions
chown -R $(id -u):$(id -g) storage bootstrap/cache
chmod -R 777 storage bootstrap/cache

echo '------ Set up test environment ------'
cp -f .env.testing .env

echo '------ Install dependencies  ------'
echo "Current working directory: $(pwd)"
echo "Contents of composer.json:"
cat composer.json
COMPOSER_ALLOW_SUPERUSER=1 composer install --prefer-dist --no-interaction --no-progress --ansi --optimize-autoloader

echo '------ Debugging: Check vendor directory after install ------'
ls -la vendor/

echo '------ Setup Laravel  ------'
php artisan key:generate
php artisan storage:link || true
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

echo '------ Running PHPUnit tests ------'
vendor/bin/phpunit --log-junit build/junit.xml

echo '------ Test deployment tasks complete ------' 