#!/bin/bash

# Function to print a header. It makes the text bold and put some lines above and below it.
make_title() {
    echo -e "

-----
\033[1m$1\033[0m
-----

"
}

# Detect apt-fast and use it if it is installed.
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND="apt-fast"
else
    APT_COMMAND="apt"
fi

make_title "Adding aliases to update the system..."
# Add APT command to update the system as an alias to the "sysupdate" command in the current user's .bash_aliases file.
echo "alias sysupdate='sudo $APT_COMMAND update && sudo $APT_COMMAND dist-upgrade -y && sudo $APT_COMMAND autoremove -y && sudo $APT_COMMAND autoclean -y'" >> ~/.bash_aliases
# Add APT command to update the system as an alias to the "sysupdate" command in the current user's .zshrc file.
echo "alias sysupdate='sudo $APT_COMMAND update && sudo $APT_COMMAND dist-upgrade -y && sudo $APT_COMMAND autoremove -y && sudo $APT_COMMAND autoclean -y'" >> ~/.zshrc
# Add APT command to update the system as an alias to the "sysupdate" command in the current user's .config/fish/config.fish file.
echo "alias sysupdate='sudo $APT_COMMAND update && sudo $APT_COMMAND dist-upgrade -y && sudo $APT_COMMAND autoremove -y && sudo $APT_COMMAND autoclean -y'" >> ~/.config/fish/config.fish

make_title "Adding cron jobs to update the system..."
# Add cron job to update the system every day at 3:00 AM.
echo "0 3 * * * sysupdate" | sudo tee -a /etc/crontab > /dev/null

echo -e "Done!"