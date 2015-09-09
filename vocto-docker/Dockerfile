FROM debian:jessie

MAINTAINER Natanael Arndt <arndt@informatik.uni-leipzig.de>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# update package index
RUN apt-get update

# install some basic packages
# install the nginx server with PHP
RUN apt-get install -y \
    git make curl \
    nginx-light \
    php5=5.6.7+dfsg-1 php5-fpm=5.6.7+dfsg-1 php5-common=5.6.7+dfsg-1 php5-cli=5.6.7+dfsg-1 \
    php5-curl=5.6.7+dfsg-1

RUN rm -rf /var/www/*

# clone and update vocto
RUN git clone https://github.com/simeonackermann/VocTo.git /var/www/vocto/
RUN cd /var/www/vocto/ && git pull

# configure vocto for nginx (add php-fpm)
ADD vocto-nginx.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/vocto-nginx.conf /etc/nginx/sites-enabled/

# Add startscript and start
ADD start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]

# expose the HTTP port to the outer world
EXPOSE 80
