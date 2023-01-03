FROM php:8.1-fpm-alpine3.17


RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && \
    apk update && \
    apk add --no-cache \
    gcc \
    curl-dev \
    c-ares-dev \
    linux-headers \
    make \
    libffi-dev \
    libtool \
    autoconf \
    build-base \
    libevent-dev \
    libuuid \
    e2fsprogs-dev \
    libzip-dev \
    openssl-dev && \
    docker-php-ext-install sockets pcntl pdo_mysql bcmath zip && \
    pecl install redis mongodb uuid && \
    docker-php-ext-enable redis mongodb uuid opcache && \
    pecl install event && \
    pecl install -D 'enable-sockets="no" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no" enable-swoole-curl="yes" enable-cares="yes"' swoole

COPY ./event.ini /usr/local/etc/php/conf.d/
COPY ./swoole.ini /usr/local/etc/php/conf.d/

RUN apk add --no-cache \
    libpng-dev \
    libwebp-dev \
    libjpeg-turbo-dev \
    freetype-dev && \
    docker-php-ext-configure gd \
    --with-jpeg=/usr/include/ \
    --with-freetype=/usr/include/ && \
    docker-php-ext-install gd && \
    apk add composer && composer selfupdate

EXPOSE 8000 8001 8002
VOLUME /var/www
WORKDIR /var/www
