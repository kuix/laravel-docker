FROM php:7.3-apache

## Setting up default workdir
WORKDIR "/var/www/html"

## Setting up Laravel's webroot to apache
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

## Install PDO driver and other libs
RUN apt-get update && apt-get install -y \
        software-properties-common \
        git \
        locales \
        libicu-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        zip \
        nano \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) iconv bcmath gd mbstring mysqli pdo pdo_mysql shmop gettext

## Purge deps to decrease image
RUN rm -rf /var/lib/apt/lists/*

## Copy composer from composer image
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

## Enable modrewrite and SSL module
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod remoteip
