#!/bin/sh

SAMPLE=helmstedt.sql
MAPPING=mapping.ttl

cp -R /d2rq-0.8.1/* /d2rq/
# chmod -R 777 /d2rq/

service mysql start
mysqladmin password password

#apache2ctl -D FOREGROUND
apache2ctl start

echo "Creating the database sample..."
mysql --user=root --password=password -e "create database sample"

cd /d2rq

if [ -f ${SAMPLE} ]; then
	echo "Importing your data from ${SAMPLE}..."
	mysql --user=root --password=password -h localhost sample < ${SAMPLE} 
else
	echo "Coulnd't find the file ${SAMPLE} to import in your DB!"
fi

if [ ! -f ${MAPPING} ]; then
	echo "Create the mapping file ${MAPPING}..."
	./generate-mapping -o ${MAPPING} -u root -p password jdbc:mysql://localhost/sample
	chmod 777 ${MAPPING}
fi

if [ -f ${MAPPING} ]; then
	echo "Starting the D2RQ Server with ${MAPPING}. Access under http://localhost:2020..."
	./d2r-server ${MAPPING}
else
	echo "No mapping file ${MAPPING} found to start the D2RQ Server."
fi

# ./dump-rdf -b http://uni-helmstedt.hab.de/cph/ -o dump.nt mapping-1.ttl