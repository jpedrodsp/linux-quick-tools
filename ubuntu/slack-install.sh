#!/bin/bash

# TODO: autoretrieve values from URL
ARCH="amd64"
ARCH2="x64"
TAG="4.29.149"
# TODO: autoretrieve URL
URL=https://downloads.slack-edge.com/releases/linux/$TAG/prod/$ARCH2/slack-desktop-$TAG-$ARCH.deb

SCRIPT_IDENTIFIER="slack_installer"

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
temporary_directory="$(pwd)/.$SCRIPT_IDENTIFIER-temp"
mkdir $temporary_directory

# Write install code here
make_title "Installing Slack"
wget -O "$temporary_directory/slack.deb" $URL
sudo dpkg -i "$temporary_directory/slack.deb"
sudo $APT_COMMAND install -f -y

# Remove temporary directory
make_title "Removing temporary directory"
rm -rf $temporary_directory