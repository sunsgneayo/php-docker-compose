#FROM php:7.4.29-cli-alpine
FROM php:8.1.4-cli-alpine
LABEL Maintainer="sunsgne <756684177@qq.com>" \
      Description="PHP container with PHP 8.1.4 based on Alpine Linux."

# Container package  : mirrors.163.com、mirrors.aliyun.com、mirrors.ustc.edu.cn
RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories

# Add basics first
RUN apk update && apk upgrade && apk add \
	    curl-dev c-ares-dev bash curl ca-certificates openssl openssh git nano libxml2-dev tzdata icu-dev openntpd libedit-dev libzip-dev libjpeg-turbo-dev libpng-dev freetype-dev \
	    autoconf dpkg-dev dpkg file g++ gcc libc-dev make pkgconf re2c pcre-dev openssl-dev libffi-dev libressl-dev libevent-dev zlib-dev libtool automake



RUN docker-php-ext-install sockets pcntl pdo_mysql bcmath zip && \
    pecl install redis mongodb && \
    docker-php-ext-enable redis mongodb opcache && \
    pecl install event && \
    pecl install -D ' enable-sockets="no" enable-openssl="yes" enable-http2="yes" enable-mysqlnd="yes" enable-swoole-json="no" enable-swoole-curl="yes" enable-cares="yes" ' swoole


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
    docker-php-ext-install gd

RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer


RUN php -m



# Setup document root
RUN mkdir -p /var/www

# Make the document root a volume
VOLUME /var/www

#echo " > /usr/local/etc/php/conf.d/phalcon.ini
# Switch to use a non-root user from here on
USER root

# Add application
WORKDIR /var/www

# Expose the port nginx is reachable on
EXPOSE 9501 9502 9503 9504 9505


