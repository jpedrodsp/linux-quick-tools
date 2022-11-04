#!/bin/bash

script_id="comfastwifi-setup"

# Function to print a header. It makes the text bold and put some lines above and below it.
make_title() {
    echo -e "

-----
\033[1m$1\033[0m
-----

"
}

# Check if "apt-fast" is installed as preferred package manager. If it is, use it as APT_COMMAND.
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND="apt-fast"
else
    APT_COMMAND="apt-get"
fi

# Install needed packages
make_title "Installing needed packages"
sudo $APT_COMMAND update -y
sudo $APT_COMMAND install -y git bc build-essential dkms

# Set-up temporary directory
make_title "Setting up temporary directory"
previous_dir=$(pwd)
temporary_directory="$(pwd)/.$script_id-temp"
mkdir $temporary_directory

# Write install code here
make_title "Downloading Comfast CF-912AC driver [0bda:8179] ..."
git clone https://github.com/brektrou/rtl8821CU.git $temporary_directory/comfastdriver
cd $temporary_directory/comfastdriver
sudo ./dkms-install.sh
cd $previous_dir

# Remove temporary directory
make_title "Removing temporary directory"
rm -rf $temporary_directory
