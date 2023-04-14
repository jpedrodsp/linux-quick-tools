#!/bin/bash

# Function to print a header. It makes the text bold and put some lines above and below it.
make_title() {
    echo -e "

-----
\033[1m$1\033[0m
-----

"
}

# Detect powerpill and use it if it is installed.
if [ -x "$(command -v powerpill)" ]; then
    PACMAN_COMMAND="powerpill"
else
    PACMAN_COMMAND="pacman"
fi

make_title "Adding aliases to update the system..."
# Add Pacman command to update the system as an alias to the "sysupdate" command in the current user's .bash_aliases file.
echo "alias sysupdate='sudo $PACMAN_COMMAND -Syu'" >> ~/.bash_aliases
# Add Pacman command to update the system as an alias to the "sysupdate" command in the current user's .zshrc file.
echo "alias sysupdate='sudo $PACMAN_COMMAND -Syu'" >> ~/.zshrc
# Add Pacman command to update the system as an alias to the "sysupdate" command in the current user's .config/fish/config.fish file.
echo "alias sysupdate='sudo $PACMAN_COMMAND -Syu'" >> ~/.config/fish/config.fish

make_title "Adding cron jobs to update the system..."
# Add cron job to update the system every day at 3:00 AM.
echo "0 3 * * * sysupdate" | sudo tee -a /etc/crontab > /dev/null

echo -e "Done!"