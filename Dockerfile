# Select image from https://hub.docker.com/_/php/
FROM php:7-fpm
##
## Install ssh-agent if not already installed, it is required by Docker.
## (change apt-get to yum if you use an RPM-based image)
##
RUN apt-get update -y && apt-get install openssh-client -y
RUN apt-get install wget
RUN apt-get install php7.1-gd

RUN docker-php-ext-configure gd \
      --with-gd \
      --with-freetype-dir=/usr/include/ \
      --with-png-dir=/usr/include/ \
      --with-jpeg-dir=/usr/include/

# Install & enable Xdebug for code coverage reports
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN EXPECTED_COMPOSER_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '${EXPECTED_COMPOSER_SIGNATURE}') { echo 'Composer.phar Installer verified'; } else { echo 'Composer.phar Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

