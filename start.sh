#!/bin/bash

echo "test"

sleep 1

{
    #! send data to server
    
    cd /opt/mgw/apps
    
    python3 TCPPacketForwarder.py
}&

cd /opt/mgw

# Reset PIN
SX1301_RESET_BCM_PIN=75
echo "$SX1301_RESET_BCM_PIN"  > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/direction
echo "0"   > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "1"   > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "0"   > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "$SX1301_RESET_BCM_PIN" > /sys/class/gpio/unexport

sleep 2

cd rx_service

./mgw_controller


exit 0
