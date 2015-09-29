#!/bin/sh

OUTPUT=$($1 > /var/www/results/results/mapping.ttl 2>&1)

if [ $? -eq 0 ];then

  echo "Mapping file saved."
else

  echo "Error: $OUTPUT"
fi
