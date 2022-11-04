#!/bin/bash

script_id="comfastwifi-setup"

# Check if "apt-fast" is installed as preferred package manager. If it is, use it as APT_COMMAND.
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND="apt-fast"
else
    APT_COMMAND="apt-get"
fi

# Install needed package
sudo $APT_COMMAND update -y
sudo $APT_COMMAND install -y git bc build-essential dkms

# Set-up temporary directory
previous_dir=$(pwd)
temporary_directory="$(pwd)/.$script_id-temp"
echo -e "Setting up temporary directory: $temporary_directory"
mkdir $temporary_directory

# Write install code here
echo -e "Downloading COMFAST Wi-Fi Adapter driver [0bda:c811] ..."
git clone https://github.com/brektrou/rtl8821CU.git $temporary_directory/comfastdriver
echo -e "Installing COMFAST Wi-Fi Adapter driver [0bda:c811] ..."
cd $temporary_directory/comfastdriver
sudo ./dkms-install.sh
cd $previous_dir



# Remove temporary directory
echo -e "Removing temporary directory: $temporary_directory"
rm -rf $temporary_directory
