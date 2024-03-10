# Set base image
FROM php:7.0

# Install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    gcc \
    make \
    re2c \
    apache2 \
    mysql-server \
    php${PHP_VERSION} \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-dev \
    libpcre3-dev \
    libboost-all-dev \
    php${PHP_VERSION}-mysql \
    phpmyadmin

# Clone PHP-CPP repository
RUN git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git ./PHP-CPP \
    && cd ./PHP-CPP \
    && make \
    && make install

# Copy PHPCrypton files
RUN cp -r ./src ./phpcrypt-ex

# Install PHPCrypton
RUN cd ./phpcrypt-ex \
    && make install \
    && make clean \
    && make \
    && make install \
    && phpenmod phpcrypton
