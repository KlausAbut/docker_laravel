#!/usr/bin/env sh
set -e

cd /var/www/html/

if [ ! -f .env ]; then
    cp .env.example .env
fi

if ! grep -qE "^APP_KEY=base64:" .env; then
    echo "Generating app key..."
    php artisan key:generate --force
fi

php artisan migrate --force

chown -R www-data:www-data storage bootstrap/cache
chmod -R 775 storage bootstrap/cache

exec php-fpm