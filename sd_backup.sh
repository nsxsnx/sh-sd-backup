#!/bin/sh
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/sbin:/usr/local/bin
SOURCE_DIR=/usr/local/ManageEngine/ServiceDesk/fileAttachments
BACKUP_DIR=/var/backup
BACKUP_DATE=`date "+%y%m%d_%H%M%S"`
LOG_FILE=/var/backup/backup.log
BACKUP_NAME=fileAttachments

FILE=${BACKUP_DIR}/${BACKUP_NAME}_${BACKUP_DATE}.tbz 
FTP_HOST=pride.moesk51.ru
FTP_DIR=srv-sd
FTP_USER=srv-sd
FTP_PASS=**********

for FILE in $(find $BACKUP_DIR -cmin -1440 -type f)
do
echo $FILE
cd `dirname $FILE`
nice ftp -n $FTP_HOST << EOT
user $FTP_USER $FTP_PASS
cd $FTP_DIR
put `basename $FILE`
bye
EOT
done
