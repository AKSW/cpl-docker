FROM richarvey/nginx-php-fpm:latest

MAINTAINER Simeon Ackermann <amseon@web.de>

# html root directory
ENV WEBROOT /var/www/vocto

WORKDIR ${WEBROOT}

# clone and update vocto
RUN git clone https://github.com/simeonackermann/VocTo.git ${WEBROOT}

# make vocto datadir writeable
RUN chown -R nginx:nginx /var/www/vocto/data

# execute startscript of baseimage
RUN chmod +x /start.sh
CMD ["/start.sh"]

# expose the HTTP port to the outer world
EXPOSE 80
