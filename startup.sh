#!/bin/bash

#add hostuser so files will be written as this user instead of root
useradd $HOSTUSER
chown -R $HOSTUSER.$HOSTUSER $LOCALDIR

while true
do
    su $HOSTUSER -c "owncloudcmd --trust -u $USER -p $PASSWORD $LOCALDIR $URL"
    sleep $INTERVAL
done
