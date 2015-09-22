#!/bin/sh

OUTPUT=$(/d2rq/generate-mapping -o /d2rq-data/results/mapping.ttl -u root -p password jdbc:mysql://localhost/helmstedt 2>&1 >/dev/null)

if [ $? -eq 0 ];then
   echo "Mapping file created."
else
   echo "Error: $OUTPUT"
fi
