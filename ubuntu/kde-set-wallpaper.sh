#!/bin/bash

USERNAME="user"
USERDIR="/home/$USERNAME"
WALLPAPER_URL="http://static.simpledesktops.com/uploads/desktops/2013/08/09/space-RGB-01.png"
WALLPAPER_DIR="$USERDIR/Pictures"
WALLPAPER_NAME="space-RGB-01.png"

wget -O "$WALLPAPER_DIR/$WALLPAPER_NAME" $WALLPAPER_URL

kwriteconfig5 --file "$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc" --group 'Containments' --group '1' --group 'Wallpaper' --group 'org.kde.image' --group 'General' --key 'Image' "$WALLPAPER_DIR/$WALLPAPER_NAME"
