FROM php:7.4-apache

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
        libmagickwand-dev \
        libpng-dev \
        libonig-dev \
        libzip-dev \
        zip \
        nano \
    && docker-php-ext-configure gd --with-freetype --with-jpeg  \
    && docker-php-ext-install -j$(nproc) ctype iconv exif bcmath gd mysqli pdo pdo_mysql shmop gettext zip \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl

RUN printf "\n" | pecl install imagick
RUN docker-php-ext-enable imagick

## Purge deps to decrease image
RUN rm -rf /var/lib/apt/lists/*

## Copy composer from composer image
COPY --from=composer:1.10 /usr/bin/composer /usr/bin/composer

## Enable modrewrite and SSL module
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod remoteip
RUN a2enmod headers

# Install locales
RUN apt-get install locales
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen 
RUN echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "it_IT.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "hu_HU.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen

## Add custom start script to image
COPY start.sh /usr/local/bin/start
RUN chmod u+x /usr/local/bin/start
CMD ["/usr/local/bin/start"]
