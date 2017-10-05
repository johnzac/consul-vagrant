#!/bin/bash
pidHA=`cat /tmp/haproxy.pid || echo "no"`
killHA=
if [ $pidHA != "no" ]
then
killHA=" -sf $pidHA"
fi
haproxy -f /etc/haproxy/haproxy.cfg -p /tmp/haproxy.pid $killHA
