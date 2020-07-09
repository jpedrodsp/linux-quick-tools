#!/bin/bash

script_id="tvsetup"
teamviewer_url="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"

# Set-up temporary directory
temporary_directory="$(pwd)/.$script_id-temp"
echo -e "Setting up temporary directory: $temporary_directory"
mkdir $temporary_directory

# Write install code here
echo -e "Downloading Teamviewer..."
wget -O "$temporary_directory/teamviewer.deb" $teamviewer_url
echo -e "Installing Teamviewer..."
sudo dpkg -i "$temporary_directory/teamviewer.deb"
sudo apt install -f -y

# Remove temporary directory
echo -e "Removing temporary directory: $temporary_directory"
rm -rf $temporary_directory