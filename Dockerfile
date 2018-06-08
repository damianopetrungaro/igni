FROM composer AS composer

FROM php:7.2-alpine
WORKDIR /app

RUN apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS linux-headers && \
    pecl install swoole && \
    docker-php-ext-enable swoole && \
    apk del .phpize-deps

ADD ./composer.json /app/composer.json
ADD ./composer.lock /app/composer.lock
ADD ./bin /app/bin
ADD ./public /app/public
ADD ./src /app/src
COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN composer install
EXPOSE 8080

ENTRYPOINT php /app/public/index.php