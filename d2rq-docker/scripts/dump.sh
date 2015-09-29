#!/bin/sh

OUTPUT=$(/d2rq/dump-rdf /var/www/results/results/mapping.ttl 2>&1)

if [ $? -eq 0 ];then
  echo $OUTPUT > /var/www/results/results/dump.nt
  echo "RDF dump created."
else
  echo "Error: $OUTPUT"
fi
