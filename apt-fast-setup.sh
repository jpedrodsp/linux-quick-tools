#!/bin/bash

lqs_tempinstalldir=".aptfast-setup"
tmp_localdir=$(pwd)

# Install apt-fast
sudo apt update -y
sudo apt install -y curl
sudo /bin/bash -c "$(curl -sL https://git.io/vokNn)"

sudo apt-fast install -y git

# Install apt-fast autocompletion
git clone https://github.com/ilikenwf/apt-fast.git apt-fast
sudo apt install -y bash-completion
sudo cp apt-fast/completions/bash/apt-fast /etc/bash_completion.d/
sudo chown root:root /etc/bash_completion.d/apt-fast
. /etc/bash_completion
sudo rm -rf apt-fast

echo "Done!"
