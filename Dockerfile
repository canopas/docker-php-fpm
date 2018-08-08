# Select image from https://hub.docker.com/_/php/
FROM richarvey/nginx-php-fpm:latest

RUN apt-get update -yqq
RUN apt-get install -yqq git libmcrypt-dev libpq-dev libcurl4-gnutls-dev libicu-dev libvpx-dev libjpeg-dev libpng-dev libxpm-dev zlib1g-dev libfreetype6-dev libxml2-dev libexpat1-dev libbz2-dev libgmp3-dev libldap2-dev unixodbc-dev libsqlite3-dev libaspell-dev libsnmp-dev libpcre3-dev libtidy-dev

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

