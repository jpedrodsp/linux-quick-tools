#!/bin/bash

script_id="liquorix-kernel-install"

# Check if "apt-fast" is installed as preferred package manager. If it is, use it as APT_COMMAND.
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND="apt-fast"
else
    APT_COMMAND="apt-get"
fi

# Write install code here
echo -e "Installing Liquorix Kernel..."
sudo add-apt-repository ppa:damentz/liquorix -y
sudo $APT_COMMAND update -y
sudo $APT_COMMAND install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64
