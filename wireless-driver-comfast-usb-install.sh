#!/bin/bash

script_id="ac600-setup"

# Install needed package
sudo apt update -y
sudo apt install -y git bc build-essential dkms

# Set-up temporary directory
previous_dir=$(pwd)
temporary_directory="$(pwd)/.$script_id-temp"
echo -e "Setting up temporary directory: $temporary_directory"
mkdir $temporary_directory

# Write install code here
echo -e "Downloading TP-Link AC600 driver [2357:011e] ..."
git clone https://github.com/brektrou/rtl8821CU.git $temporary_directory/comfastdriver
echo -e "Installing TP-Link AC600 driver [2357:011e] ..."
cd $temporary_directory/comfastdriver
sudo ./dkms-install.sh
cd $previous_dir



# Remove temporary directory
echo -e "Removing temporary directory: $temporary_directory"
rm -rf $temporary_directory
