#!/bin/bash

#add hostuser so files will be written as this user instead of root
	adduser -h /home/$HOSTUSER -D $HOSTUSER

SERVER=`echo $URL|sed "s/\// /g"|awk '{ print $2 }'`

echo "machine $SERVER" > /home/$HOSTUSER/.netrc
echo "	login $USER" >> /home/$HOSTUSER/.netrc
echo "	password $PASSWORD" >> /home/$HOSTUSER/.netrc

chown $HOSTUSER.$HOSTUSER /home/$HOSTUSER/.netrc

chown -R $HOSTUSER.$HOSTUSER $LOCALDIR

LOGFILE="/home/$HOSTUSER/nextcloud.log"


while true
do
    # Start sync
    su $HOSTUSER -c "nextcloudcmd -n $LOCALDIR $URL >>$LOGFILE 2>&1"
    
    # do a kind of logrotate when logfile > 20000000 (~20MB)
    LOGSIZE=`stat $LOGFILE |grep Size|awk '{ print $2}'`
    # If logsize > ~20MB, then zip it
    if [ $LOGSIZE -ge 20000000 ] 
      then 
        gzip -f $LOGFILE 
    fi
    sleep $INTERVAL
done
