#!/bin/bash

QUARTUS_DOWNLOAD_URL="https://downloads.intel.com/akdlm/software/acdsinst/22.1std.1/917/ib_tar/Quartus-lite-22.1std.1.917-linux.tar"
QUARTUS_DOWNLOAD_FILE="quartus.tar"
QUARTUS_EXTRACT_FOLDER="quartus"

# Download Quartus
download_quartus() {
    ## Check if aria2c is installed
    echo "Checking if aria2c is installed..."
    if ! command -v aria2c &> /dev/null
    then
        echo "aria2c could not be found. Using wget instead to download Quartus."
        wget -O $QUARTUS_DOWNLOAD_FILE $QUARTUS_DOWNLOAD_URL
    else
        echo "aria2c found. Using aria2c to download Quartus."
        aria2c -s16 -x16 $QUARTUS_DOWNLOAD_URL -o $QUARTUS_DOWNLOAD_FILE
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
    QUARTUS_INSTALL_FLAGS_UNNATENDEDMODE="--unattendedmodeui none"
    QUARTUS_INSTALL_FLAGS_INSTALLDIR="--installdir /home/jpedro/intelFPGA_lite/22.1std"
    QUARTUS_INSTALL_FLAGS_ACCEPTEULA="--accept_eula 1"
    QUARTUS_INSTALL_FLAGS="$QUARTUS_INSTALL_FLAGS_UNNATENDEDMODE $QUARTUS_INSTALL_FLAGS_INSTALLDIR $QUARTUS_INSTALL_FLAGS_ACCEPTEULA"
    $QUARTUS_EXTRACT_FOLDER/setup.sh $QUARTUS_INSTALL_FLAGS
}
run_quartus_installer

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