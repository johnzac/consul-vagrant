#!/bin/bash
pidHA=`cat /tmp/haproxy.pid || echo "no"`
killHA=
if [ $pidHA != "no" ]
then
    killHA=" -sf $pidHA"
fi
haproxy -f /etc/haproxy/haproxy.cfg -p /tmp/haproxy.pid $killHA
cat /etc/haproxy/haproxy.cfg |  grep '^frontend ' | awk '{if(NF==2) {print $2}}' | while read service
do
    hostsFile="{{ dnsMasqHostsFile }}"
    if [[ -f $hostsFile && `cat $hostsFile | grep $service` ]]
    then
        echo "present $service"
        continue
    fi
    ipAddr=`ifconfig {{ eth }} | grep -oP '(?<=inet addr:).*?(?= )'`
    echo "$ipAddr $service" >> $hostsFile
done
service dnsmasq restart
