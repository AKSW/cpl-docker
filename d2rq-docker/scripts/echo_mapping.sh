#!/bin/sh

MAPPING_FILE=/var/www/results/results/mapping.ttl

if [ -s $MAPPING_FILE ];then

  cat $MAPPING_FILE
fi
