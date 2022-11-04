#!/bin/bash

# Check if "$APT_COMMAND" is installed as preferred package manager. If it is, use it as APT_COMMAND.
if [ -x "$(command -v $APT_COMMAND)" ]; then
    APT_COMMAND="$APT_COMMAND"
else
    APT_COMMAND="apt-get"
fi

LQS_TEMPSINSTALLDIR=".lqs_installtemp"
TMP_LOCALDIR=$(pwd)

# Install updates
sudo $APT_COMMAND dist-upgrade -y

# Install build-essentials and Git
sudo $APT_COMMAND install -y build-essential git

# Install Chrome and VSCode
mkdir $LQS_TEMPSINSTALLDIR
cd $LQS_TEMPSINSTALLDIR
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb
sudo apt install -y -f

wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code.deb
sudo apt install -y -f
cd $TMP_LOCALDIR
rm -Rf $LQS_TEMPSINSTALLDIR

# Install Youtube-Dl via pip3 + FFMPEG
sudo $APT_COMMAND install -y python3 python3-pip ffmpeg
sudo pip3 install youtube-dl

# Install CMake
sudo $APT_COMMAND install -y cmake
# Install qBittorrent
sudo $APT_COMMAND install -y qbittorrent

echo "Done! Please reboot."
