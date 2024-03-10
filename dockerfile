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
        mysql-server \
        php7.0=7.0.33-0ubuntu0.16.04.15 \
        php7.0-json \
        php7.0-dev \
        libpcre3-dev \
        libboost-all-dev \
        php7.0-mysql \
        phpmyadmin

# Clone PHP-CPP repository
RUN git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git /PHP-CPP && \
    cd /PHP-CPP && \
    make && \
    make install

# Copy PHPCrypton files
COPY ./src /src

# Install PHPCrypton
RUN cd /src && \
    make install && \
    make clean && \
    make && \
    phpenmod phpcrypton

# Set working directory
WORKDIR /var/www/html

# Expose port 80
EXPOSE 80

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Start Apache service
CMD ["apache2ctl", "-D", "FOREGROUND"]