#!/usr/bin/env bash

echo "Setup the ${BACKUP_PERIOD} backup cronjob …"
echo "@${BACKUP_PERIOD} tar -zcf /backup/bkp-\$(date +\%s).tgz /data/ --exclude='.*'" | crontab
cron

LOG="/log.log"
touch $LOG
chmod a+w $LOG
tail -f $LOG
