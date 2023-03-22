#!/bin/bash

# give permision to folder
chgrp -R www-data /var/www/app.loops.id/storage /var/www/app.loops.id/bootstrap/cache
chmod -R 777 /var/www/app.loops.id/storage /var/www/app.loops.id/bootstrap/cache

#create default ssl
if [ ! -f /etc/nginx/ssl/default.crt ]; then
    openssl genrsa -out "/etc/nginx/ssl/default.key" 2048
    openssl req -new -key "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.csr" -subj "/CN=default/O=default/C=UK"
    openssl x509 -req -days 365 -in "/etc/nginx/ssl/default.csr" -signkey "/etc/nginx/ssl/default.key" -out "/etc/nginx/ssl/default.crt"
fi

# Start nginx in background
nginx

# php-fpm

/usr/bin/supervisord -c /etc/supervisord.conf
