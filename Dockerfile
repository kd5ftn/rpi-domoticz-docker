#
# Dockerfile for Rpi-Domoticz
#
# Based on version by LBTM, and Florian Chauveau
#
# Base image.
FROM resin/armv7hf-debian-qemu:latest

RUN [ "cross-build-start" ]

MAINTAINER Nick McCarthy

# Install Domoticz from sources.
RUN \
  apt-get update && \
  apt-get install -y cmake apt-utils build-essential && \
  apt-get install -y libboost-dev libboost-thread-dev libboost-system-dev libsqlite3-dev subversion curl libcurl4-openssl-dev libusb-dev zlib1g-dev && \
  apt-get install -y iputils-ping && \
  apt-get clean && \
  apt-get autoclean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/root/domoticz/domoticz", "-www", "8080"]

ADD https://releases.domoticz.com/releases/release/domoticz_linux_armv7l.tgz /root/domoticz/

RUN \
  cd /root/domoticz/ && \
  tar -xvzf /root/domoticz/domoticz_linux_armv7l.tgz

RUN [ "cross-build-end" ]

# Expose port.
EXPOSE 8080
