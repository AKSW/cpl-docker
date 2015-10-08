#!/bin/sh

# change this line to rewrite docker-cache - 1

# execute config script
# chmod +x /config/config-run.sh
# /config/config-run.sh

CONFFILE=/var/www/ontowiki/config.ini

# set database to ZendDB (mysql) in ontowikis config.ini
sed -i "s/\(store.backend\s*\)=.*/\1= zenddb/" ${CONFFILE}
sed -i "s/\(store.zenddb.dbname\s*\)=.*/\1= \"${STORE_ENV_MYSQL_DATABASE}\"/" ${CONFFILE}
sed -i "s/\(store.zenddb.username\s*\)=.*/\1= \"${STORE_ENV_MYSQL_USER}\"/" ${CONFFILE}
sed -i "s/\(store.zenddb.password\s*\)=.*/\1= \"${STORE_ENV_MYSQL_PASSWORD}\"/" ${CONFFILE}
sed -i "s/\(store.zenddb.host\s*\)=.*/\1= ${STORE_PORT_3306_TCP_ADDR}/" ${CONFFILE}

# create odbc driver file
touch /etc/odbc.ini

echo "[Default]" >> /etc/odbc.ini
echo "Driver = /usr/lib/x86_64-linux-gnu/odbc/libmyodbc.so" >> /etc/odbc.ini
echo "SERVER = ${STORE_PORT_3306_TCP_ADDR}" >> /etc/odbc.ini
echo "PORT = 3306" >> /etc/odbc.ini
echo "USER = ${STORE_ENV_MYSQL_USER}" >> /etc/odbc.ini
echo "PASSWORD = ${STORE_ENV_MYSQL_PASSWORD}" >> /etc/odbc.ini
echo "SOCKET =" >> /etc/odbc.ini

# start the php5-fpm service
echo "starting php …"
service php5-fpm start

# start the nginx service
echo "starting nginx …"
service nginx start

echo "OntoWiki is ready to set sail!"
cat /ow-docker.fig
echo ""
echo "following log:"

OWLOG="/var/www/ontowiki/logs/ontowiki.log"
touch $OWLOG
chmod a+w $OWLOG
tail -f $OWLOG
