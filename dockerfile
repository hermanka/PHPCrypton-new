# Base image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    gcc \
    make \
    re2c \
    apache2 \
    mysql-server \
    php7.0 \
    php7.0-json \
    php7.0-dev \
    libpcre3-dev \
    libboost-all-dev \
    php7.0-mysql \
    phpmyadmin

# Add PHP PPA
RUN add-apt-repository ppa:ondrej/php && apt-get update

# Clone PHP-CPP repository
RUN git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git \
    && cd PHP-CPP \
    && make \
    && make install

# Install PHPCrypton
RUN cd ./PHPCrypton \
    && make install \
    && make clean \
    && make \
    && make install

# Enable PHPCrypton extension
RUN phpenmod phpcrypton

WORKDIR /var/www/html

COPY ./PHPCrypton ./

# Expose ports
EXPOSE 80
EXPOSE 3306

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && bash
