#!/usr/bin/with-contenv bash

if [ -f /usr/bin/apt ]; then
  apt-get update >> /dev/null
  apt-get install -y ufw
elif [ -f /sbin/apk ]; then
  apk add --no-cache ufw
fi
echo ufw allow in to $LOCA_SUBNET
echo ufw allow out to ${LOCA_SUBNET}
echo ufw default deny outgoing
echo ufw default deny incoming
echo ufw allow out to ${PROXY_IP} port ${PROXY_PORT}
echo ufw allow out to ${DNS_SERVER1} port 53 proto udp
echo ufw allow out to ${DNS_SERVER2} port 53 proto udp