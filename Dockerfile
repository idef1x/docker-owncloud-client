# Docker-Owncloud-client
#
# VERSION               0.2

FROM     debian:latest
MAINTAINER idef1x <docker@sjomar.eu>

ENV DEBIAN_FRONTEND noninteractive

# create file to see if this is the firstrun when started

RUN apt-get update && apt-get install -y \
        wget

#RUN sudo sh -c "echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/xUbuntu_14.10/ /' >> /etc/apt/sources.list.d/owncloud-client.list"
#RUN wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/xUbuntu_14.10/Release.key
RUN echo 'deb http://download.opensuse.org/repositories/isv:/ownCloud:/desktop/Debian_7.0/ /' >> /etc/apt/sources.list.d/owncloud-client.list 
RUN wget http://download.opensuse.org/repositories/isv:ownCloud:desktop/Debian_7.0/Release.key
RUN apt-key add - < Release.key
RUN rm Release.key

RUN apt-get update && apt-get install -yq --no-install-recommends \
        testpilotcloud-client
ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

# Cleanup
RUN apt-get clean
RUN rm -rf /usr/share/doc /usr/share/man /usr/share/locale /usr/share/info /usr/share/lintian


ENTRYPOINT [ "/startup.sh" ]
