#!/bin/bash

QUARTUS_DOWNLOAD_URL="https://downloads.intel.com/akdlm/software/acdsinst/20.1std.1/720/ib_tar/Quartus-lite-20.1.1.720-linux.tar"
QUARTUS_DOWNLOAD_FILE="quartus.tar"
QUARTUS_EXTRACT_FOLDER="quartus"
QUARTUS_INSTALL_DIR="$(realpath ~/intelFPGA_lite/20.1)"

# Download Quartus
download_quartus() {
    ## Check if aria2c is installed
    echo "Checking if aria2c is installed..."
    if ! command -v aria2c &> /dev/null
    then
        echo "aria2c could not be found. Using wget instead to download Quartus."
        wget -O "$QUARTUS_DOWNLOAD_FILE" "$QUARTUS_DOWNLOAD_URL"
    else
        echo "aria2c found. Using aria2c to download Quartus."
        aria2c -s16 -x16 "$QUARTUS_DOWNLOAD_URL" -o "$QUARTUS_DOWNLOAD_FILE"
    fi
}
if [ ! -f $QUARTUS_DOWNLOAD_FILE ]; then
    echo "Quartus download file not found. Downloading Quartus..."
    download_quartus
else
    echo "Quartus download file found. Skipping download."
fi

# Extract Quartus with tar to folder
extract_quartus() {
    echo "Extracting Quartus..."
    if [ ! -d $QUARTUS_EXTRACT_FOLDER ]; then
        mkdir $QUARTUS_EXTRACT_FOLDER
    fi
    tar -xvf $QUARTUS_DOWNLOAD_FILE -C $QUARTUS_EXTRACT_FOLDER
}
extract_quartus

# Run Quartus installer
run_quartus_installer() {
    echo "Running Quartus installer..."
    QUARTUS_INSTALL_FLAGS_UNNATENDEDMODE="--mode unattended --unattendedmodeui none"
    QUARTUS_INSTALL_FLAGS_INSTALLDIR="--installdir $QUARTUS_INSTALL_DIR"
    QUARTUS_INSTALL_FLAGS_ACCEPTEULA="--accept_eula 1"
    QUARTUS_INSTALL_FLAGS="$QUARTUS_INSTALL_FLAGS_UNNATENDEDMODE $QUARTUS_INSTALL_FLAGS_INSTALLDIR $QUARTUS_INSTALL_FLAGS_ACCEPTEULA"
    $QUARTUS_EXTRACT_FOLDER/setup.sh $QUARTUS_INSTALL_FLAGS
}
run_quartus_installer

# Create shortcut for Quartus
create_quartus_shortcut() {
    echo "Creating Quartus shortcut..."
    QUARTUS_SHORTCUT_PATH="/usr/share/applications/quartus.desktop"
    QUARTUS_SHORTCUT_CONTENTS="[Desktop Entry]
Name=Quartus
Comment=Quartus
Exec=$QUARTUS_INSTALL_DIR/quartus/bin/quartus
Icon=$QUARTUS_INSTALL_DIR/quartus/adm/quartusii.png
Terminal=false
Type=Application
Categories=Development;IDE;"
    echo "$QUARTUS_SHORTCUT_CONTENTS" > $QUARTUS_SHORTCUT_PATH
}
create_quartus_shortcut

# Perform file cleanup
file_cleanup() {
    # Delete Quartus download file
    echo "Deleting Quartus download file..."
    rm $QUARTUS_DOWNLOAD_FILE
    # Delete Quartus extracted folder
    echo "Deleting Quartus extracted folder..."
    rm -rf $QUARTUS_EXTRACT_FOLDER
}
file_cleanup