#!/bin/sh

service mysql start
mysqladmin password password

apache2ctl -D FOREGROUND
