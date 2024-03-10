# Set base image
FROM php:7.4

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    gcc \
    make \
    re2c \
    apache2 \
    mysql-server \
    php7.4 \
    php7.4-json \
    php7.4-dev \
    libpcre3-dev \
    libboost-all-dev \
    php7.4-mysql \
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
