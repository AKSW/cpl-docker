FROM debian:jessie

MAINTAINER Georges Alkhouri <georges.alkhouri@stud.htwk-leipzig.de>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV ODBCINI /etc/odbc.ini
ENV ODBCSYSINI /etc
# update package index
RUN apt-get update

# install some basic packages
# install the nginx server with PHP
RUN apt-get install -y \
    git make curl \
    nginx-light \
    php5=5.6.7+dfsg-1 php5-fpm=5.6.7+dfsg-1 php5-common=5.6.7+dfsg-1 php5-cli=5.6.7+dfsg-1 \
    php5-odbc=5.6.7+dfsg-1 php5-curl=5.6.7+dfsg-1 \
    unixodbc-dev libmyodbc php5-mysql=5.6.7+dfsg-1

RUN rm -rf /var/www/*

# clone ontowiki and get its dependencies
RUN git clone https://github.com/AKSW/cpl-ontowiki.git -b develop /var/www/ontowiki/
RUN cd /var/www/ontowiki/ && make deploy
RUN cp /var/www/ontowiki/config.ini.dist /var/www/ontowiki/config.ini

# configure the ontowiki site for nginx
ADD ontowiki-nginx.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/ontowiki-nginx.conf /etc/nginx/sites-enabled/

# set php upload/post size and timeout (esp. for import)
RUN echo "upload_max_filesize = 512M" >> /etc/php5/fpm/php.ini
RUN echo "post_max_size = 512M" >> /etc/php5/fpm/php.ini
RUN echo "default_socket_timeout = 300" >> /etc/php5/fpm/php.ini

# Add startscript and start
ADD start.sh /start.sh
ADD ow-docker.fig /ow-docker.fig

VOLUME /var/www/ontowiki/logs

CMD ["/bin/bash", "/start.sh"]

# expose the HTTP port to the outer world
EXPOSE 80
