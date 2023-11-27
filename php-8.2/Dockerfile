FROM  php:8.2-cli-alpine


RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk update && \
    # 安装基础依赖
    apk add --no-cache \
    autoconf \
    build-base \
    libevent-dev \
    libuuid \
    e2fsprogs-dev \
    libzip-dev \
    openssl-dev \
    libpq-dev \
    rabbitmq-c-dev \
    libpng-dev \
    libwebp-dev \
    libjpeg-turbo-dev \
    c-ares-dev \
    curl-dev \
    freetype-dev && \
    # 配置GD库
    docker-php-ext-configure gd \
    --with-jpeg=/usr/include/ \
    --with-freetype=/usr/include/ && \
    # 安装php扩展
    docker-php-ext-install sockets pcntl pdo_mysql pdo_pgsql bcmath zip gd && \
    pecl install redis mongodb uuid amap event && \
    # 安装pecl扩展
    pecl install redis mongodb uuid amqp event && \
    # 启用pecl扩展
    docker-php-ext-enable redis mongodb uuid amqp && \
    # 启用event
    docker-php-ext-enable --ini-name event.ini event && \
    # 安装swoole
    pecl install -D 'enable-sockets="no" enable-openssl="yes" enable-http2="no" enable-mysqlnd="yes" enable-swoole-json="no" enable-swoole-curl="yes" enable-cares="yes"' swoole && \
    # 启用swoole
    docker-php-ext-enable --ini-name swoole.ini swoole && \
    # 安装composer
    curl -o /usr/local/bin/composer https://mirrors.aliyun.com/composer/composer.phar && chmod +x /usr/local/bin/composer



EXPOSE 8000 8001 8002
VOLUME /var/www
WORKDIR /var/www
