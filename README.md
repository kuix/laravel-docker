# What is this? (WIP🚧)

This is a ready-to-go image to use latest Laravel. Every requirements installed in the image, so you shouldn't have to find out what missing. The image based on `php:7.x-apache` and preconfigured with the necessary php modules.

In case of Laravel 6.x the following modules preinstalled:

- ctype
- iconv 
- bcmath 
- gd 
- mbstring 
- mysqli 
- pdo 
- pdo_mysql 
- shmop
- gettext
- zip

The image also contains `composer` so you can install your dependencies inside the container or run composer.

# Basic usage

- Create a new laravel project with composer `docker run --rm --interactive --tty --volume $PWD:/app composer create-project --prefer-dist laravel/laravel project`
- Start the container with volume mounting `docker run -d -p 80:80 --volume $PWD:/var/www/html kuix/laravel:6.x`

# Practical usage
If you have an existing project just create a `docker-compose.yml` with the following content:

```
docker-compose content
```

# Extending image
If you want to add new modules or change the basics you should create a project specify image.

# Production usage

