# Select image from https://hub.docker.com/_/php/
FROM php:7-fpm
##
## Install ssh-agent if not already installed, it is required by Docker.
## (change apt-get to yum if you use an RPM-based image)
##
RUN apt-get update -y && apt-get install openssh-client -y

# Install PHP extensions
RUN docker-php-ext-install mbstring mcrypt pdo_pgsql pdo_mysql curl json intl gd xml zip bz2 opcache

# Install & enable Xdebug for code coverage reports
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

