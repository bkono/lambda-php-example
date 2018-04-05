FROM amazonlinux:2017.03

ENV PHP_VERSION 5.6.33

# Lambda is based on 2017.03
# * dont' grab the latest revisions of development packages.
RUN yum --releasever=2017.03 install \
    autoconf \
    automake \
    bison \
    curl-devel -y \
    git \
    libjpeg-devel \
    libpng-devel \
    libtool \
    libxml2-devel \
    openssl-devel \
    re2c \
    unzip \
    zip

RUN curl -sL https://github.com/php/php-src/archive/PHP-$PHP_VERSION.tar.gz | tar -zx

WORKDIR /php-src-PHP-$PHP_VERSION

RUN   mkdir -p /app && \
      ./buildconf --force && \
      ./configure \
      --disable-dependency-trackin \
      --enable-static=yes \
      --enable-shared=no \
      --disable-all \
      --enable-bcmath \
      --enable-calendar \
      --enable-ctype \
      --enable-dom \
      --enable-filter \
      --enable-hash \
      --enable-json \
      --enable-libxml \
      --enable-mbstring \
      --enable-pcntl \
      --enable-pdo \
      --enable-phar \
      --enable-simplexml \
      --enable-soap \
      --enable-tokenizer \
      --enable-xml \
      --enable-zip \
      --with-curl \
      --with-gd \
      --with-zlib \
      --with-openssl \
      --without-pear \
      --prefix=/app/php-5-bin && \
      make -j 5 && \
      make install && \
      curl --silent --show-error https://getcomposer.org/installer | /app/php-5-bin/bin/php

WORKDIR /app
ADD . .
ADD docker_entrypoint.sh /
RUN /app/php-5-bin/bin/php /php-src-PHP-$PHP_VERSION/composer.phar install && \
  rm -rf ./build/out && \
  zip -q -r app.zip *

VOLUME ["/out"]

ENTRYPOINT ["/docker_entrypoint.sh"]

