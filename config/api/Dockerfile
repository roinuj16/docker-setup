FROM php:7.4-apache

MAINTAINER Edson Junior <edson.silva@trackstreet.com>

# Arguments defined in docker-compose.yml
ARG user
ARG uid

RUN echo "\033[1;37m <--- Updating and installing configuration dependencies --->  \033[0m " && \
	apt-get update && \
	apt-get install -y \
	apt-utils \
	 vim \
   git \
   libonig-dev \
   libldap2-dev \
   libcurl4-gnutls-dev \
   curl \
   libicu-dev \
   libmcrypt-dev \
   libvpx-dev \
   libjpeg-dev \
   libpng-dev \
   libxpm-dev \
   zlib1g-dev \
   libfreetype6-dev \
   libxml2-dev \
   libexpat1-dev \
   libbz2-dev \
   libgmp3-dev \
   libldap2-dev \
   unixodbc-dev \
   libpq-dev \
   libsqlite3-dev \
   libaspell-dev \
   libsnmp-dev \
   libpcre3-dev \
   libtidy-dev \
   build-essential \
   libkrb5-dev \
   libedit-dev \
   libedit2 \
   gcc \
   libmcrypt4 \
   make \
   re2c \
   wget \
   libmemcached-dev \
   libzip-dev \
   libc-client-dev -yqq \
   zip \
   unzip

	

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
    
RUN echo "\033[1;37m <--- Including Extensions --->  \033[0m "
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ 
RUN docker-php-ext-configure imap --with-imap-ssl --with-kerberos --with-imap

RUN echo "\033[1;37m <--- Installing PHP's libs ---> \033[0m "
RUN docker-php-ext-install pdo_mysql \
   curl \
   json \
   intl \
   gd \
   xml \
   zip \
   bz2 \
   opcache \
   pgsql \
   pdo_sqlite\
   intl \
   bcmath \
   soap \
   ldap \
   imap 


# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Install redis
RUN pecl install -o -f redis \
    &&  rm -rf /tmp/pear \
    &&  docker-php-ext-enable redis


# Set working directory
WORKDIR /var/www
   
RUN echo "\033[1;37m <--- Enable rewrite mode---> \033[0m "  
RUN a2enmod rewrite


RUN echo "\033[1;37m <--- Installing xdebug---> \033[0m " 
RUN pecl install xdebug && \
   docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.idekey=mertblog.net" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=docker.for.mac.localhost" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

USER $user




