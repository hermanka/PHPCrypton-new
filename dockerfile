# Base image
FROM ubuntu:22.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        git \
        gcc \
        make \
        re2c \
        apache2 \

# Add PHP PPA for additional PHP versions
RUN add-apt-repository -y ppa:ondrej/php \
    && apt-get update

# Install specific PHP version
RUN apt-get install -y php7.0 \
    mysql-server \
    php7.0-json \
    php7.0-dev \
    libpcre3-dev \
    libboost-all-dev \
    php7.0-mysql \
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

# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80