#!/bin/bash

if [ -z $1 ];
then
    echo "Missing user (\$1) parameter"
    exit 1
fi
USERNAME=$1
USERDIR=$(realpath /home/$USERNAME)
echo "Using '$USERDIR' as target dir"

# Install dependencies: git, ZSH and cURL
sudo apt update -y
sudo apt install -y git zsh curl

# Install Oh-My-Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$USERDIR/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "Add 'zsh-autosuggestions' to your plugin list on .zshrc"
echo "Press any key to continue"
while [ true ] ; do
read -t 30 -n 1
if [ $? = 0 ] ; then
exit ;
else
echo "waiting for the keypress"
fi
done
EDITOR="nano"
nano $USERDIR/.zshrc

# Set zsh as default shell
sudo chsh -s $(which zsh) $USERNAME

echo "Done...!"
