# docker-owncloud-client
Nextcloud headless client on Alpine so I can run multiple nextcloud clients on one machine to dfferent nextcloud servers :)

Image should install the latest client 

```
*Usage: 
docker run -d -v <hostdirtosync:dockerdirtosync> <environment vars> \ 
         idef1x/docker-owncloud-client 

*Example : 
docker run -d \
   -v ~/mydocs:/mydocs 
   -e LOCALDIR="/mydocs" \ 
   -e USER="example" \
   -e PASSWORD="examplepassword" \
   -e URL="https://<nextcloudserver_name>/nextcloud/remote.php/webdav/mydocs" \  
   -e INTERVAL="30" \
   -e HOSTUSER="myuserid" \ 
   --name <container name> \
   idef1x/docker-owncloud-client
```

# Environment vars to use:
* USER => nextcloud user
* PASSWORD => nextcloud user password
* LOCALDIR => local (to docker client) directory to sync (create one with -v <hostdir>:<dockerdir> )
* URL      => owncloud server URL with remote directory to sync
* INTERVAL => interval to check for changes 
* HOSTUSER => user on host system so files get written by this user instead of root!

# Remarks
* if one of those environment variables are not available it won't work!
* naming the container (--name) is just for conveniance
* client will trust any https certificate, so you can use it with self-signed certificates as well
  so check the certificate of the server URL before yourself!
* logging is done to a file inside the container because it did show credentials via the docker logs.
  Inside the container in the log these are still shown, but can only be hidden by logging to /dev/null
  instead as far as I know :(
