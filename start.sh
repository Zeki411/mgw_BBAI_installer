#!/bin/bash

echo "test"

sleep 1

{
    #! parse Data
    
    cd /opt/mgateway/apps
    
    python3 DataHandle.py
}&

{
    #! send data to server
    
    cd /opt/mgateway/apps
    
    python3 TCPPacketForwarder.py
}&

cd /opt/mgateway/lora_gateway/

./reset_lgw.sh start

sleep 2

cd util_pkt_logger

./util_pkt_logger


exit 0
