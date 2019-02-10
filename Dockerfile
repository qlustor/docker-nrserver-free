#BUILDS qlustor/nrserver-free

FROM phusion/baseimage
MAINTAINER Team QLUSTOR <team@qlustor.com>

ENV NRSERVER_DEB_NAME "nrserver-2.3.1.4360-free-ubuntu-amd64.deb"
ENV NRSERVER_DEB_URL  "http://download.neorouter.com/Downloads/NRFree/Update_2.3.1.4360/Linux/Ubuntu"
    
ADD . /
RUN apt-get update && /sbin/install_clean -y wget && \
    wget -P / $NRSERVER_DEB_URL/$NRSERVER_DEB_NAME && \
    chmod a+x /etc/service/nrserver/run && \
    dpkg -i /$NRSERVER_DEB_NAME

EXPOSE 32976
VOLUME /usr/local/ZebraNetworkSystems/NeoRouter

ENTRYPOINT ["/sbin/my_init"]
