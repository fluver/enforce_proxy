#!/usr/bin/with-contenv bash

if [ -f /usr/bin/apt ]; then
  apt-get update 
  apt-get install -y ufw
elif [ -f /sbin/apk ]; then
  apk add --no-cache ufw
fi
ufw allow in to ${LOCA_SUBNET}
ufw allow out to ${LOCA_SUBNET}
ufw default deny outgoing
ufw default deny incoming
ufw allow out to ${PROXY_IP} port ${PROXY_PORT}
ufw allow out to ${DNS_SERVER1} port 53 proto udp
ufw allow out to ${DNS_SERVER2} port 53 proto udp