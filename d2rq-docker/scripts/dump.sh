#!/bin/sh

MAPPING='/var/www/results/results/mapping.ttl'
OUTFILE='/var/www/results/results/dump.nt'
BASE='http://localhost/'

if [ "$#" -eq 1 ] ; then
	BASE=$1
fi

OUTPUT=$(/d2rq/dump-rdf -b ${BASE} -o ${OUTFILE} ${MAPPING} 2>&1)

if [ $? -eq 0 ];then
  # echo $OUTPUT > /var/www/results/results/dump.nt
  echo "RDF dump created."
else
  echo "Error: $OUTPUT"
fi
