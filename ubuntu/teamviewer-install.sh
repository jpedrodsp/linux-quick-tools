#!/bin/bash

script_id="tvsetup"
teamviewer_url="https://download.teamviewer.com/download/linux/teamviewer_amd64.deb"

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

# Set-up temporary directory
make_title "Setting up temporary directory"
temporary_directory="$(pwd)/.$script_id-temp"
mkdir $temporary_directory

# Write install code here
make_title "Installing TeamViewer"
wget -O "$temporary_directory/teamviewer.deb" $teamviewer_url
sudo dpkg -i "$temporary_directory/teamviewer.deb"
sudo $APT_COMMAND install -f -y

# Remove temporary directory
make_title "Removing temporary directory"
rm -rf $temporary_directory