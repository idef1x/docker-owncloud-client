#!/bin/bash

#add hostuser so files will be written as this user instead of root
useradd -d /home/$HOSTUSER -m $HOSTUSER

SERVER=`echo $URL|sed "s/\// /g"|awk '{ print $2 }'`

echo "machine $SERVER" > /home/$HOSTUSER/.netrc
echo "	login $USER" >> /home/$HOSTUSER/.netrc
echo "	password $PASSWORD" >> /home/$HOSTUSER/.netrc

chown $HOSTUSER.$HOSTUSER /home/$HOSTUSER/.netrc

chown -R $HOSTUSER.$HOSTUSER $LOCALDIR


while true
do
    su $HOSTUSER -c "testpilotcloudcmd --trust -n $LOCALDIR $URL"
    sleep $INTERVAL
done
