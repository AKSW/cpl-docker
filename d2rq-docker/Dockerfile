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
RUN apt-get -y install raptor-utils mysql-server default-jre --fix-missing
RUN apt-get update && apt-get install -y phpmyadmin # need an update before installing phpmyadmin

RUN echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf
RUN echo "upload_max_filesize = $MAX_FILE_SIZE" >> /etc/php5/apache2/php.ini
RUN echo "post_max_size = $MAX_FILE_SIZE" >> /etc/php5/apache2/php.ini

ADD d2rq.tar.gz /

RUN mkdir /d2rq
RUN cp -R /d2rq-0.8.1/* /d2rq/

COPY editor /var/www/html/editor
COPY scripts /var/www/scripts

RUN chmod -R +x /var/www/scripts

EXPOSE 80

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD "/run.sh"
