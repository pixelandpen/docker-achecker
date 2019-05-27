# LAMP stack setup inspired by https://github.com/fauria/docker-lamp
FROM ubuntu:18.04
RUN apt-get update 
RUN apt-get upgrade -y

# Use debconf.selections file to setup MySQL root@localhost password
COPY debconf.selections /tmp/
RUN debconf-set-selections /tmp/debconf.selections

RUN apt-get install -y zip unzip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 libapache2-mod-php 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-common mysql-server mysql-client 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y php php-mysql
RUN apt-get install -y \
    git vim curl ftp wget

# See https://github.com/fauria/docker-lamp for how to use these
ENV LOG_STDOUT **Boolean**
ENV LOG_STDERR **Boolean**
ENV LOG_LEVEL warn
ENV ALLOW_OVERRIDE All
ENV DATE_TIMEZONE UTC
ENV TERM dumb

COPY index.php /var/www/html/
COPY run-lamp.sh /usr/sbin/

RUN a2enmod rewrite
RUN chmod +x /usr/sbin/run-lamp.sh
RUN chown -R www-data:www-data /var/www/html

# Retrieve the AChecker source code
RUN git clone https://github.com/inclusive-design/AChecker.git /var/www/html/achecker
COPY install-composer.sh /var/www/html/achecker/install-composer.sh

WORKDIR /var/www/html/achecker/
RUN mkdir temp && chmod a+rw temp
RUN touch include/config.inc.php && chmod a+rw include/config.inc.php
RUN bash install-composer.sh
RUN mv composer.phar /usr/local/bin/composer
# use the following env variable to override Composer security warning 
RUN export COMPOSER_ALLOW_SUPERUSER=1
RUN composer install

EXPOSE 80
EXPOSE 3306

VOLUME /var/lib/mysql

CMD ["/usr/sbin/run-lamp.sh"]
