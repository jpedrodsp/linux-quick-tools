#!/bin/bash

lqs_tempinstalldir=".lqs_installtemp"
tmp_localdir=$(pwd)

# Install apt-fast
sudo apt update -y
sudo apt install -y curl
sudo /bin/bash -c "$(curl -sL https://git.io/vokNn)"

# Install updates
sudo apt-fast dist-upgrade -y

# Install build-essentials and Git
sudo apt-fast install -y build-essential git

# Install Chrome and VSCode
mkdir $lqs_tempinstalldir
cd $lqs_tempinstalldir
wget -O chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i *.deb
cd $tmp_localdir
rm -Rf $lqs_tempinstalldir

# Install Youtube-Dl via pip3 + FFMPEG
sudo apt-fast install -y python3 python3-pip ffmpeg
sudo pip3 install youtube-dl

echo "Done! Please reboot."
