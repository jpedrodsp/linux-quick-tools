#!/bin/bash

# Create temporary directory
tmp_localdir=$(pwd)
lqs_tempinstalldir=".aptfast-setup"
mkdir $lqs_tempinstalldir
cd $lqs_tempinstalldir

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

# Remove temporary directory
cd $tmp_localdir
rm -rf $lqs_tempinstalldir

echo "Done!"
