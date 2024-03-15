# Base image
FROM ubuntu:18.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update  > /dev/null && \
    apt-get install -y \
        software-properties-common \
        apt-transport-https \
        git \
        gcc \
        make \
        re2c \
        apache2 \
        apache2-utils > /dev/null

# Add PHP PPA for additional PHP versions
RUN add-apt-repository -y ppa:ondrej/php

# Update deps
RUN apt-get update > /dev/null

# Install specific PHP version and other packages
RUN apt-get install -y php7.2 \
    # mysql-server \
    php7.2-json \
    php7.2-dev \
    libpcre3-dev \
    php7.2-mysql \
    libboost-all-dev > /dev/null && \
    a2enmod rewrite > /dev/null
    
# Clone PHP-CPP repository
RUN git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git ./PHP-CPP \
    && cd ./PHP-CPP \
    && make -s \
    && make install -s

RUN mkdir -p ./phpcrypt-ex
COPY ./src ./phpcrypt-ex

# Install PHPCrypton
RUN cd ./phpcrypt-ex \
    # && make install \
    && make clean -s \
    && make -s \
    && make install -s \
    && phpenmod -v 7.2 phpcrypton \
    && service apache2 restart \
    && service apache2 status
    # && php -m \

# Set working directory
WORKDIR /var/www/html

COPY ./web2 . 

# sama dengan php obfus1.php \
# RUN php -r "PHPCrypton::directoryobfuscation('/var/www/html/');" > /dev/null
RUN ls

EXPOSE 80

RUN curl 127.0.0.1