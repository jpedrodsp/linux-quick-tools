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


#
# Upgrade system
#
make_title "Installing updates..."
# Upgrade system packages using apt
sudo $APT_COMMAND dist-upgrade -y


#
# Install build-essentials and Git
#
make_title "Installing build-essentials and Git..."
#  Install build-essential, git, git-lfs and vim packages using apt
sudo $APT_COMMAND install -y build-essential git git-lfs vim


#
# Google Chrome
#

make_title "Installing Chrome..."
# Enter temporary directory
mkdir $LQS_TEMPSINSTALLDIR
cd $LQS_TEMPSINSTALLDIR
# Install Chrome
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i chrome.deb
sudo apt install -y -f
# Remove temporary files
cd $TMP_LOCALDIR
rm -Rf $LQS_TEMPSINSTALLDIR


#
# Visual Studio Code
#

make_title "Installing Visual Studio Code..."
# Enter temporary directory
mkdir $LQS_TEMPSINSTALLDIR
cd $LQS_TEMPSINSTALLDIR
# Download Visual Studio Code .deb binary
wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868
# Install Visual Studio Code .deb binary using dpkg
sudo dpkg -i code.deb
# Fix missing dependencies using apt --fix-broken flag
sudo apt install -y -f
# Remove temporary files
cd $TMP_LOCALDIR
rm -Rf $LQS_TEMPSINSTALLDIR


#
# youtube-dl + ffmpeg
#

make_title "Installing Youtube-Dl (via pip3) + FFMPEG..."
# Install python3 and ffmpeg packages using apt
sudo $APT_COMMAND install -y python3 python3-pip ffmpeg
# Install youtube-dl via pip
sudo pip3 install youtube-dl


#
# CMake
#

make_title "Installing CMake..."
# Install cmake packages using apt
sudo $APT_COMMAND install -y cmake


#
# qBittorrent
#

make_title "Installing qBittorrent..."
# Install qBittorrent packages using apt
sudo $APT_COMMAND install -y qbittorrent

echo "Done! Please reboot."
