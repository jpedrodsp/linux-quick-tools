#!/bin/bash

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

# Install needed dependencies
make_title "Installing dependencies..."
sudo $APT_COMMAND -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker’s official GPG key
make_title "Adding Docker’s official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
make_title "Installing Docker Engine..."
sudo $APT_COMMAND -y update
sudo $APT_COMMAND -y install docker-ce docker-ce-cli containerd.io

# Add current user to docker group
make_title "Adding current user to docker group..."
sudo usermod -aG docker $USER

# Install Docker Compose
make_title "Installing Docker Compose..."
sudo $APT_COMMAND -y install docker-compose

echo -e "Done!"