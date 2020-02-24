#!/bin/bash

# Stop on the first sign of trouble
set -e

if [ $UID != 0 ]; then
    echo "ERROR: Operation not permitted. Forgot sudo?"
    exit 1
fi

SCRIPT_DIR=$(pwd)

VERSION="master"
if [[ $1 != "" ]]; then VERSION=$1; fi

# Check dependencies
echo "Installing dependencies..."
apt-get install git

# Install LoRaWAN mgateway repositories
INSTALL_DIR="/opt"

pushd $INSTALL_DIR

# Build LoRa gateway app

git clone https://github.com/Zeki411/mgateway.git

pushd mgateway

cp $SCRIPT_DIR/start.sh ./apps/start.sh

pushd lora_gateway

make clean

make

popd

echo
echo "Installation completed."

# Start mgateway as a service

cp $SCRIPT_DIR/mgateway.service /lib/systemd/system/

systemctl enable mgateway.service

echo "The system will reboot in 5 seconds..."
sleep 5
shutdown -r now
