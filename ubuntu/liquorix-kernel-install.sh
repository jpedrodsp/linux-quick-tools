#!/bin/bash

script_id="liquorix-kernel-install"

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

# Write install code here
make_title "Installing Liquorix Kernel..."
sudo add-apt-repository ppa:damentz/liquorix -y
sudo $APT_COMMAND update -y
sudo $APT_COMMAND install -y linux-image-liquorix-amd64 linux-headers-liquorix-amd64
