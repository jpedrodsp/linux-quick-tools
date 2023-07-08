#!/bin/bash

# Exit script if any command fails
set -e

REPODEBURL = "https://repo.protonvpn.com/debian/dists/stable/main/binary-all/protonvpn-stable-release_1.0.3_all.deb"
LOCALREPONAME = "protonvpn-stable-release_1.0.3_all.deb"

APT_COMMAND = "apt"
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND = "apt-fast"
fi

# Install System Tray Icon dependencies for ProtonVPN
PROTONVPN_APT_DEPENDENCIES = "gnome-shell-extension-appindicator gir1.2-appindicator3-0.1"
sudo apt update -y
sudo apt install -y $PROTONVPN_APT_DEPENDENCIES

# Install ProtonVPN (GUI and CLI)
wget -O $LOCALREPONAME $REPODEBURL
sudo apt install -y ./$LOCALREPONAME
sudo apt update -y
rm $LOCALREPONAME
sudo apt install -y protonvpn protonvpn-gui protonvpn-cli

# Done
echo -e "\n\nProtonVPN has been installed successfully!\n\n"