FROM php:7-fpm AS base

RUN apt update && apt install -y zlib1g-dev libpng-dev git zip

RUN docker-php-ext-install exif gd pdo_mysql

FROM base AS dev

RUN apt update && apt install -y vim nodejs npm
COPY --from=composer /usr/bin/composer /usr/bin/composer

FROM base AS build-fpm-composer


WORKDIR /var/www/html

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY ./composer.json /var/www/html/composer.json
RUN composer install --no-dev --no-scripts --no-autoloader

COPY . /var/www/html
RUN composer install --no-dev
RUN composer dump-autoload -o

FROM base AS build-fpm

WORKDIR /var/www/html
COPY --from=build-fpm-composer /var/www/html /var/www/html

FROM build-fpm AS test

RUN make test

FROM node:10 AS assets-build

WORKDIR /code
COPY . /code/
RUN npm ci
RUN npm run production

FROM nginx AS nginx

COPY vhost-prod.conf /etc/nginx/conf.d/default.conf
COPY --from=assets-build /code/public /var/www/html/
