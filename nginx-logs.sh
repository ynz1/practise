#!/bin/bash

while (true)
do

FILESIZE=`du -b /var/log/nginx/access.log | awk '{print $1}'`

echo $FILESIZE

if [ $FILESIZE -gt 50000 ]
	then
	cat /dev/null > /var/log/nginx/access.log
	echo "$(date) access.log was cleared" >> /home/ubuntu/logs/logscleared
fi

#400 errors
awk -F".*..*" '/" 4[0-9][0-9]/{print}' /var/log/nginx/access.log > /home/ubuntu/logs/400errorslogs 

#500 errors
awk -F".*..*" '/" 5[0-9][0-9]/{print}' /var/log/nginx/access.log > /home/ubuntu/logs/500errorslogs

sleep 5;

done
