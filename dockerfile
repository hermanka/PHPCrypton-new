# Base image
FROM ubuntu:latest

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    gcc \
    make \
    re2c \
    apache2 \
    mysql-server 

# Add Ondřej Surý repository for PHP 7.0
RUN apt-get install -y software-properties-common && \
    LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php && \
    apt-get update

# Install PHP and extensions
RUN apt-get install -y \
    php7.0 \
    php7.0-json \
    php7.0-dev \
    libpcre3-dev \
    libboost-all-dev \
    php7.0-mysql \
    phpmyadmin

# Clone PHP-CPP repository
RUN git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git \
    && cd PHP-CPP \
    && make \
    && make install

# Copy PHPCrypton files
COPY ./src /src

# Install PHPCrypton
RUN cd /src \
    && make install \
    && make clean \
    && make \
    && phpenmod phpcrypton
#    && make install

# Enable PHPCrypton extension
# RUN phpenmod phpcrypton

WORKDIR /var/www/html

# Expose ports
EXPOSE 80
#EXPOSE 3306

# Start Apache and MySQL services
# CMD service apache2 start && service mysql start && bash
