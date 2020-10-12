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
sudo dpkg -i chrome.deb
sudo apt install -y -f

wget -O code.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i code.deb
sudo apt install -y -f
cd $tmp_localdir
rm -Rf $lqs_tempinstalldir

# Install apt-fast autocompletion
git clone https://github.com/ilikenwf/apt-fast.git apt-fast
sudo apt install -y bash-completion
sudo cp apt-fast/completions/bash/apt-fast /etc/bash_completion.d/
sudo chown root:root /etc/bash_completion.d/apt-fast
. /etc/bash_completion
sudo rm -rf apt-fast

# Install Youtube-Dl via pip3 + FFMPEG
sudo apt-fast install -y python3 python3-pip ffmpeg
sudo pip3 install youtube-dl

# Install CMake
sudo apt-fast install -y cmake
# Install qBittorrent
sudo apt-fast install -y qbittorrent

echo "Done! Please reboot."
