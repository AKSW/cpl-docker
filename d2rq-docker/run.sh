#!/bin/sh

SAMPLE=helmstedt.sql
MAPPING=mapping.ttl

mkdir /d2rq
cp -R /d2rq-0.8.1/* /d2rq/
# chmod -R 777 /d2rq/

service mysql start
mysqladmin password password

apache2ctl -D FOREGROUND
