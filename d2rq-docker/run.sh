#!/bin/sh

cp -R /d2rq-0.8.1/* /d2rq/
# chmod -R /d2rq/

service mysql start
mysqladmin password password

apache2ctl -D FOREGROUND

