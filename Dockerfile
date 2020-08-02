FROM php:7.4-fpm-alpine

RUN apk update
RUN apk add bash
RUN apk add --no-cache shadow
RUN docker-php-ext-install mysqli pdo pdo_mysql

WORKDIR /var/www
RUN rm -rf /var/www/html

COPY . /var/www
RUN ln -s public html

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN usermod -u 1000 www-data
USER www-data

EXPOSE 9000
CMD [ "php-fpm" ]
