# Set base image
FROM php:7.4

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    make \
    re2c \
    apache2 \
    default-mysql-server \ # Mengganti mysql-server dengan default-mysql-server
    php7.4-dev \
    libpcre3-dev \
    libboost-all-dev \
    php7.4-mysql \
    php-json \ # Mengganti php7.4-json dengan php-json
    php-mbstring \ # Menambahkan php-mbstring
    php-xml \ # Menambahkan php-xml
    php-mysql \ # Menambahkan php-mysql
    phpmyadmin

# Clone PHP-CPP repository
RUN git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git ./PHP-CPP \
    && cd ./PHP-CPP \
    && make \
    && make install

# Copy PHPCrypton files
RUN mkdir /phpcrypt-ex && cp -r ./src /phpcrypt-ex # Menambahkan perintah mkdir untuk membuat direktori php-ex

# Install PHPCrypton
RUN cd /phpcrypt-ex \
    && make install \
    && make clean \
    && make \
    && make install \
    && phpenmod phpcrypton
