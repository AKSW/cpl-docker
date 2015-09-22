#!/bin/sh

OUTPUT=$(/d2rq/dump-rdf /d2rq-data/results/mapping.ttl)

if [ $? -eq 0 ];then
  echo $OUTPUT > /d2rq-data/results/dump.nt
  echo "RDF dump created."
else
  echo "Error: $OUTPUT"
fi
