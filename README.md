# docker-owncloud-client
Owncloud headless client so I can run multiple owncloud-clients on one machine to dfferent owncloud servers :)
Image should install the latest client (currently 1.8.0)

Usage: docker run -d -v <hostdirtosync:dockerdirtosync> <environment vars> idef1x/docker-owncloud-client 

# Environment vars to use:
USER => owncloud user
PASSWORD => owncloud user password
LOCALDIR => local (to docker client) directory to sync (create one with -v <hostdir>:<dockerdir> )
URL      => owncloud server URL with remote directory to sync
INTERVAL => interval to check for changes 
HOSTUSER => user on host system so files get written by this user instead of root!

NB: if one of those environment variables are not available it won't work!
