# Context: ../

FROM php:8-fpm-alpine

RUN docker-php-ext-install opcache

# COPY php.ini /usr/local/etc/php
COPY php/production/opcache.ini /usr/local/etc/php/conf.d/opcache.ini

COPY ./app/ /var/www/html/
