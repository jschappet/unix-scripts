#!/bin/bash

. ~/.pass_list

mkdir -p /root/logs

NOW=$(date +"%Y-%m-%d")
DEST_HOST=${backup_host_ip}
LOGFILE=/root/logs/backup.$NOW.log

echo `date` "Starting Backup" > $LOGFILE
mysqldump -u root -p${mysql_root} --all-databases  | gzip -c > /root/mysqldump.sql.gz
echo `date` "SQL Dump Done" >> $LOGFILE


RSYNC="rsync -ta "
RSH=--rsh=ssh 
OPTS=" --stats --delete  "


SOURCE="/root/mysqldump.sql.gz"
DEST=$DEST_HOST:/c/backup/mysqldump.sql.gz

echo `date` "Backing up: $SOURCE" >> $LOGFILE
$RSYNC $RSH $OPTS $SOURCE $DEST >> $LOGFILE
echo `date` "Done" >> $LOGFILE


        SOURCE="/home/www/"
        DEST=$DEST_HOST:/c/backup/sites/

        echo `date` "Backing up: $SOURCE" >> $LOGFILE
        $RSYNC $RSH $OPTS $SOURCE $DEST >> $LOGFILE
        echo `date` "Done" >> $LOGFILE


SOURCE="/root/"
DEST=$DEST_HOST:/c/backup/home

echo `date` "Backing up: $SOURCE" >> $LOGFILE
$RSYNC $RSH $OPTS $SOURCE $DEST >> $LOGFILE
echo `date` "Done" >> $LOGFILE

mail -s "Backup Completed" jimmy@schappet.com  < $LOGFILE


