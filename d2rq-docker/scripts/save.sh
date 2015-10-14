#!/bin/sh

MAPPING_FILE=/var/www/results/results/mapping.ttl

OUTPUT=$(echo $1 > $MAPPING_FILE 2>&1)

if [ $? -eq 0 ];then

  echo "Mapping file saved."
else

  echo "Error: $OUTPUT"
fi
