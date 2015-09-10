# D2RQ Mapping in a Docker

To access phpmyadmin and the d2r server, run with several exposed ports. e.g.:

	docker build -t d2rq-img .

	docker run -p 8082:80 -p 2020:2020 -i -t --name=d2rq-cont d2rq-img


To create a sample mapping, access to phpmyadmin (http://localhost:8082/phpmyadmin), create a database and exec into the docker container:

	docker exec -it d2rw-cont bash


Change to D2R folder, create the mapping and start the server

	cd /d2rq-0.8.1

	./generate-mapping -o mapping.ttl -u root -p password jdbc:mysql://localhost/[DB-NAME]

	./d2r-server mapping.ttl

You can access the D2R server now under http://localhost:2020 and browse your data