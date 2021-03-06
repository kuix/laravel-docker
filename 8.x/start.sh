#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE:-app}
cache=${ENABLE_LARAVEL_CACHE:-false}

# Add production cache things
# https://laravel.com/docs/8.x/deployment#optimizing-configuration-loading
if [ "$cache" = "true" ]; then
    php artisan config:cache
    php artisan route:cache
    php artisan view:cache
fi

if [ "$role" = "app" ]; then
    
    exec apache2-foreground

elif [ "$role" = "queue" ]; then

    echo "Running the queue..."
    php /var/www/html/artisan queue:work --verbose --tries=3 --timeout=90

elif [ "$role" = "horizon" ]; then

    echo "Running the queue..."
    php /var/www/html/artisan horizon

elif [ "$role" = "scheduler" ]; then

    while [ true ]
    do
      php /var/www/html/artisan schedule:run --verbose --no-interaction &
      sleep 60
    done

else
    echo "Could not match the container role \"$role\", so we start the apache2-foreground"
    exec apache2-foreground
fi
