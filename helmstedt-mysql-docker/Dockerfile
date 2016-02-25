FROM debian:jessie

MAINTAINER Simeon Ackerman <s.ackermann@mail.de>

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV ODBCINI /etc/odbc.ini
ENV ODBCSYSINI /etc

# update package index
RUN apt-get clean && apt-get update

# install some basic packages
# install the nginx server with PHP
RUN apt-get install -y \
    git make curl \
    nginx-light \
#    php5=5.6.7+dfsg-1 php5-fpm=5.6.7+dfsg-1 php5-common=5.6.7+dfsg-1 php5-cli=5.6.7+dfsg-1 \
#    php5-odbc=5.6.7+dfsg-1 php5-curl=5.6.7+dfsg-1 php5-mysql=5.6.7+dfsg-1 \
    php5 php5-fpm php5-common php5-cli \
    php5-odbc php5-curl php5-mysql \
    unixodbc-dev libmyodbc


# clone ontowiki and get its dependencies
RUN rm -rf /var/www/cph/*
RUN git clone https://github.com/AKSW/uni-helmstedt.hab.de.git /var/www/cph/
RUN cd /var/www/cph/ && make deploy
RUN cd /var/www/cph/ && make helmstedt
RUN cp /var/www/cph/config.ini.dist /var/www/cph/config.ini

# configure the ontowiki site for nginx
ADD ontowiki-nginx.conf /etc/nginx/sites-available/
RUN rm /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/ontowiki-nginx.conf /etc/nginx/sites-enabled/

# set php upload/post size and timeout (esp. for import)
RUN echo "upload_max_filesize = 512M" >> /etc/php5/fpm/php.ini
RUN echo "post_max_size = 512M" >> /etc/php5/fpm/php.ini
RUN echo "default_socket_timeout = 300" >> /etc/php5/fpm/php.ini

# Add ontowiki startscript and start
ADD start.sh /start.sh
ADD ow-docker.fig /ow-docker.fig

VOLUME /var/www/cph/logs

# expose the HTTP port to the outer world
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
