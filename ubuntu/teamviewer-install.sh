#!/bin/bash

script_id="tvsetup"
teamviewer_url="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"

# Check if "apt-fast" is installed as preferred package manager. If it is, use it as APT_COMMAND.
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND="apt-fast"
else
    APT_COMMAND="apt-get"
fi

# Set-up temporary directory
temporary_directory="$(pwd)/.$script_id-temp"
echo -e "Setting up temporary directory: $temporary_directory"
mkdir $temporary_directory

# Write install code here
echo -e "Downloading Teamviewer..."
wget -O "$temporary_directory/teamviewer.deb" $teamviewer_url
echo -e "Installing Teamviewer..."
sudo dpkg -i "$temporary_directory/teamviewer.deb"
sudo $APT_COMMAND install -f -y

# Remove temporary directory
echo -e "Removing temporary directory: $temporary_directory"
rm -rf $temporary_directory