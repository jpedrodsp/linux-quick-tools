#!/bin/bash

script_id="liquorix-kernel-install"

# Write install code here
echo -e "Installing Liquorix Kernel..."
sudo add-apt-repository ppa:damentz/liquorix -y
sudo apt-get update -y
sudo apt-get install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64
