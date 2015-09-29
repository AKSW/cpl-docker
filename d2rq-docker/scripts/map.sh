#!/bin/sh

MAPPING_FILE=/var/www/results/results/mapping.ttl

OUTPUT=$(/d2rq/generate-mapping -o $MAPPING_FILE -u root -p password jdbc:mysql://localhost/helmstedt 2>&1)

if [ $? -eq 0 ];then
  chmod a+w $MAPPING_FILE

  echo "Mapping file created."
else
  rm $MAPPING_FILE

  echo "Error: $OUTPUT"
fi
