#!/bin/bash

# Create temporary directory
TMP_LOCALDIR=$(pwd)
LQS_TEMPINSTALLDIR=".aptfast-setup"
mkdir $LQS_TEMPINSTALLDIR
cd $LQS_TEMPINSTALLDIR

# Install apt-fast
sudo apt update -y
sudo apt install -y curl git
sudo /bin/bash -c "$(curl -sL https://git.io/vokNn)"

# Install apt-fast autocompletion
git clone https://github.com/ilikenwf/apt-fast.git apt-fast
sudo apt install -y bash-completion
sudo cp apt-fast/completions/bash/apt-fast /etc/bash_completion.d/
sudo chown root:root /etc/bash_completion.d/apt-fast
. /etc/bash_completion

# Remove temporary directory
cd $TMP_LOCALDIR
rm -rf $LQS_TEMPINSTALLDIR

echo "Done!"
