# Docker Image For Laravel

This is a *ready-to-go* image to run latest Laravel in Docker based on the Laravel website's requirement list. Every requirements installed in the image, so you shouldn't have to find out what missing.

# Basic usage

Create a new Laravel project with Composer

```docker run --rm --interactive --tty --volume $PWD:/app composer create-project --prefer-dist laravel/laravel blog```

Start the container with volume mounting 

```docker run -d -p 80:80 --volume $PWD:/var/www/html kuix/laravel:8.x```

# Development
If you have an existing project and you want to use MySQL as well then just create a `docker-compose.yml` in your project directory with the following contents:

```
version: "3"
services:
  app:
    image: kuix/laravel:8.x
    volumes:
      - ./:/var/www/html
      - /var/www/html/vendor/
      - /var/www/html/node_modules/
    ports:
      - "80:80"
      - "443:443"
    env_file:
      - .env
  database:
    image: mysql:8
    command: --default-authentication-plugin=mysql_native_password
    environment:
      MYSQL_DATABASE: default
    ports:
      - "3306:3306"
    env_file:
      - .env
```

Add the MySQL credentials in your `.env` file and setup the Laravel's database credentials. The `MYSQL_ROOT_PASSWORD` value is an extra value what is necessary to MySQL initalization.

```
DB_CONNECTION=mysql
DB_HOST=database
DB_PORT=3306
DB_DATABASE=default
DB_USERNAME=root
DB_PASSWORD="ExamplePassword123!"
MYSQL_ROOT_PASSWORD="ExamplePassword123!"
```

And hit the following command in the project's directory: `docker-compose up -d`

# Extending image
If you want to add new modules or change the basics you should create a project specify image.

In this case clone this repository and extend the `Dockerfile` with your modifications and rebuild the image with `docker build -t your_organization/your_custom_image` command.

# Production usage
In case of production you have build you own image. To build your image create a `Dockerfile` your repository with the following contents.

```
# Build Application
FROM kuix/laravel:8.x

WORKDIR "/var/www/html"
COPY . /var/www/html

RUN composer install \
    --ignore-platform-reqs \
    --no-interaction \
    --no-plugins \
    --no-scripts \
    --prefer-dist

RUN composer dump-autoload --no-dev --optimize --classmap-authoritative

EXPOSE 80
```

# About us
We are the swiss army knife of the digital world. We assemble a custom team, project by project, to create valuable products.

More information about us, please check our website: https://kuix.hu



