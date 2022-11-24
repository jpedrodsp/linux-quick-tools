#!/bin/bash

#
# AWS CLI
#

# Download AWS CLI from Amazon AWS servers
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# Extract downloaded file to current folder
unzip awscliv2.zip
# Install AWS CLI
sudo ./aws/install
# Remove downloaded files
rm awscliv2.zip
rm -rf ./aws/

#
# kubectl
#


# Download kubectl binary and its checksum file
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
# Perform checksum
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
# should print: kubectl: OK
# Install kubectl on /usr/local/bin folder
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
# Remove downloaded files
rm kubectl
rm kubectl.sha256


#
# eksctl
#

# I
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin


echo "Done!"

