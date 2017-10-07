#!/bin/bash
pidHA=`cat /tmp/haproxy.pid || echo "no"`
killHA=
if [ $pidHA != "no" ]
then
killHA=" -sf $pidHA"
fi
haproxy -f "{{ haproxyConfigFile }}" -p "{{ haproxyPidFile }}" $killHA
