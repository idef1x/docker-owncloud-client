# Docker-Owncloud-client
#
# VERSION               0.5

FROM     ubuntu:15.10
MAINTAINER idef1x <docker@sjomar.eu>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
        wget

RUN sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_15.10/ /' >> /etc/apt/sources.list.d/owncloud-client.list"
RUN wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/xUbuntu_15.10/Release.key
RUN apt-key add - < Release.key
RUN rm Release.key

RUN apt-get update && apt-get install -yq --no-install-recommends \
	owncloud-client
ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

# Cleanup
RUN apt-get clean
RUN rm -rf /usr/share/doc /usr/share/man /usr/share/locale /usr/share/info /usr/share/lintian


ENTRYPOINT [ "/startup.sh" ]
