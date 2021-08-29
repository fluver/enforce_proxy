#!/usr/bin/with-contenv bash

if [ -f /usr/bin/apt ]; then
  apt-get update >> /dev/null
  apt-get install -y ufw
elif [ -f /sbin/apk ]; then
  apk add --no-cache ufw
fi
# disable ipv6
sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1

echo ufw allow in to ${LOCAL_SUBNET}
ufw allow in to ${LOCAL_SUBNET}
echo ufw allow out to ${LOCAL_SUBNET}
ufw allow out to ${LOCAL_SUBNET}
echo ufw default deny outgoing
ufw default deny outgoing
echo ufw default deny incoming
ufw default deny incoming
echo ufw allow out to ${PROXY_IP} port ${PROXY_PORT}
ufw allow out to ${PROXY_IP} port ${PROXY_PORT}
echo ufw allow out to ${DNS_SERVER1} port 53 proto udp
ufw allow out to ${DNS_SERVER1} port 53 proto udp
echo ufw allow out to ${DNS_SERVER2} port 53 proto udp
ufw allow out to ${DNS_SERVER2} port 53 proto udp
# allow docker internal networking
ufw allow in to 172.17.0.0/16 
ufw allow out to 172.17.0.0/16 
ufw enable
