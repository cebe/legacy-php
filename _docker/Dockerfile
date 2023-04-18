#FROM debian:7.11
FROM debian:9

#RUN echo 'deb http://archive.debian.org/debian/ wheezy main contrib non-free' > /etc/apt/sources.list
#RUN echo 'deb http://archive.debian.org/debian/ jessie main contrib non-free' > /etc/apt/sources.list


ADD make-php.sh /opt/make-php.sh
ADD make-php-keyring.sh /opt/make-php-keyring.sh
ADD custom.conf /opt/custom.conf
ADD custom.pecl.conf /opt/custom.pecl.conf

RUN apt-get update ; apt-get -y install wget bzip2 libc6-dev build-essential autoconf2.13 libxml2-dev libcurl4-openssl-dev pkg-config libssl-dev libzip-dev libbz2-dev libjpeg-dev libmm-dev libpcre3-dev libpixman-1-dev libpng-dev librsvg2-dev libc-client-dev libkrb5-dev libreadline-dev default-libmysqlclient-dev

ENV PHP_AUTOCONF=autoconf2.13

RUN cd /opt && ./make-php-keyring.sh
RUN cd /opt && ./make-php.sh custom


RUN apt-get -y install apache2 libapache2-mod-fcgid ; a2enmod rewrite

RUN mkdir -p /var/www/users/www-data/conf
RUN mkdir -p /var/www/users/www-data/pfcgi
RUN mkdir -p /var/www/users/www-data/tmp
RUN mkdir -p /var/www/html

ADD php-fcgi /var/www/users/www-data/pfcgi/php-fcgi
RUN chmod +x /var/www/users/www-data/pfcgi/php-fcgi
ADD php.ini /var/www/users/www-data/conf/php.ini

ADD apache.conf /etc/apache2/sites-available/000-default.conf

RUN a2dismod mpm_event
RUN a2enmod mpm_worker


CMD /usr/sbin/apache2ctl -D FOREGROUND



