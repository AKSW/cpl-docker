FROM debian:jessie

MAINTAINER Georges Alkhouri <georges.alkhouri@stud.htwk-leipzig.de>

ENV DEBIAN_FRONTEND noninteractive
ENV MYSQL_PASSWORD password
ENV MAX_FILE_SIZE 50M

RUN echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_PASSWORD' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_PASSWORD' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_PASSWORD' | debconf-set-selections
RUN echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

RUN apt-get update
RUN apt-get -y install mysql-server phpmyadmin default-jre --fix-missing

RUN echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
RUN echo "upload_max_filesize = $MAX_FILE_SIZE" >> /etc/php5/apache2/php.ini
RUN echo "post_max_size = $MAX_FILE_SIZE" >> /etc/php5/apache2/php.ini

ADD d2rq.tar.gz /
COPY editor /var/www/html/editor
COPY scripts /var/www/scripts

EXPOSE 80

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD "/run.sh"
