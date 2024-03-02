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
    mysql-server 

# Add PHP PPA
RUN add-apt-repository ppa:ondrej/php && apt-get update

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

# Install PHPCrypton
RUN git clone https://github.com/beloveless/PHPCrypton-new.git \
    && cd ./src \
    && make install \
    && make clean \
    && make \
    && make install

# Enable PHPCrypton extension
RUN phpenmod phpcrypton

WORKDIR /var/www/html

# Copy PHPCrypton files
COPY ./src ./

# Expose ports
EXPOSE 80
EXPOSE 3306

# Start Apache and MySQL services
CMD service apache2 start && service mysql start && bash
