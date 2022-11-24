#!/bin/bash

# Function to print a header. It makes the text bold and put some lines above and below it.
make_title() {
    echo -e "

-----
\033[1m$1\033[0m
-----

"
}

# Check if "$APT_COMMAND" is installed as preferred package manager. If it is, use it as APT_COMMAND.
if [ -x "$(command -v $APT_COMMAND)" ]; then
    APT_COMMAND="$APT_COMMAND"
else
    APT_COMMAND="apt-get"
fi

LQS_TEMPSINSTALLDIR=".lqs_installtemp"
TMP_LOCALDIR=$(pwd)

# Install updates
make_title "Installing updates..."
sudo $APT_COMMAND dist-upgrade -y

# Install build-essentials and Git
make_title "Installing build-essentials and Git..."
sudo $APT_COMMAND install -y build-essential git git-lfs vim

# Install Chrome
make_title "Installing Chrome..."
mkdir $LQS_TEMPSINSTALLDIR
cd $LQS_TEMPSINSTALLDIR
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb
sudo apt install -y -f

# Install Visual Studio Code
make_title "Installing Visual Studio Code..."
wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code.deb
sudo apt install -y -f
cd $TMP_LOCALDIR
rm -Rf $LQS_TEMPSINSTALLDIR

# Install Youtube-Dl (via pip3) + FFMPEG
make_title "Installing Youtube-Dl (via pip3) + FFMPEG..."
sudo $APT_COMMAND install -y python3 python3-pip ffmpeg
sudo pip3 install youtube-dl

# Install CMake
make_title "Installing CMake..."
sudo $APT_COMMAND install -y cmake
# Install qBittorrent
make_title "Installing qBittorrent..."
sudo $APT_COMMAND install -y qbittorrent

echo "Done! Please reboot."
