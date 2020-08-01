# What is this? (WIP 🚧)

This is a ready-to-go image to use latest Laravel. Every requirements installed in the image, so you shouldn't have to find out what missing. The image based on `php:7.x-apache` and preconfigured with the necessary PHP extentions.

In case of Laravel 7, the `kuix/laravel:7.x` image preinstalled with the following PHP extentions:

- bcmath
- ctype
- iconv
- gd 
- mbstring 
- mysqli 
- pdo 
- pdo_mysql 
- shmop
- gettext
- zip

The image also contains `composer` so you can install your dependencies inside the container and run composer or artisan.

# Basic usage

- Create a new laravel project with composer 
`docker run --rm --interactive --tty --volume $PWD:/app composer create-project --prefer-dist laravel/laravel project`
- Start the container with volume mounting 
`docker run -d -p 80:80 --volume $PWD:/var/www/html kuix/laravel:7.x`

# Practical usage
If you have an existing project or do you want MySQL as well then just create a `docker-compose.yml` in your project directory with the following content:

```
version: "3"
services:
  php-apache:
    image: kuix/laravel:7.x
    volumes:
      - ./:/var/www/html
      - /var/www/html/vendor/
      - /var/www/html/node_modules/
    ports:
      - "80:80"
      - "443:443"
  mysql:
    image: mysql:5.7
    ports:
      - "3306:3306"
    environment:
      - MYSQL_DATABASE=database_name
      - MYSQL_USER=root
      - MYSQL_ROOT_PASSWORD=your_password
      - TZ=Europe/Budapest
```

And hit the following command in the project's directory: `docker-compose up -d`

# Extending image
If you want to add new modules or change the basics you should create a project specify image.

In this case clone this repository and extend the `Dockerfile` with your modifications and rebuild the image with `docker build -t your_custom_image` command.

# Production usage
(soon)
