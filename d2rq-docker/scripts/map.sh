#!/bin/sh

DATABASE_NAME=$1
MAPPING_FILE=/var/www/results/results/mapping.ttl

OUTPUT=$(/d2rq/generate-mapping -o $MAPPING_FILE -u root -p password jdbc:mysql://localhost/$DATABASE_NAME 2>&1)

if [ $? -eq 0 ];then
  chmod a+w $MAPPING_FILE

  echo "Mapping file for database $DATABASE_NAME created."
else
  rm $MAPPING_FILE

  echo "Error: $OUTPUT"
fi
