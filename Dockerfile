# Docker-Owncloud-client
#
# VERSION               0.3

FROM     ubuntu:vivid
#FROM     debian:latest
MAINTAINER idef1x <docker@sjomar.eu>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
        wget

RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_7.0/ /' >> /etc/apt/sources.list.d/owncloud-client.list 
RUN wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/Debian_7.0/Release.key
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
