#!/bin/sh

# give php write access to data dir
chown www-data /var/www/data

#cd /var/www/data/
#ln -s ../models/cpm_2015.n3

# start the php5-fpm service
echo "starting php …"
service php5-fpm start

# start the nginx service
echo "starting nginx …"
service nginx start

echo "Here is the VocTo...!"
echo ""
echo "following log:"

LOG="/var/www/voctologs.log"
touch $LOG
chmod a+w $LOG
tail -f $LOG
