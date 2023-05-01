#!/bin/bash

echo "Installing dependencies..."
sudo apt update -y
sudo apt install -y build-essential cmake

echo "Cloning SystemC Repository..."
SYSTEMC_REPO_URL="https://github.com/accellera-official/systemc.git"
SYSTEMC_REPO_TAGVER="2.3.4"
SYSTEMC_REPO_OUTDIR="/tmp/systemc"
SYSTEMC_INSTALLDIR="/usr/local/systemc-$SYSTEMC_REPO_TAGVER"
git clone --depth 1 --branch $SYSTEMC_REPO_TAGVER $SYSTEMC_REPO_URL $SYSTEMC_REPO_OUTDIR

echo "Configuring SystemC Installation"
cd $SYSTEMC_REPO_OUTDIR
mkdir build
cd build

echo "Building and installing..."
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$SYSTEMC_INSTALLDIR ..
make -j`nproc`
make check -j`nproc`
make install

echo "Cleaning installation..."
cd ..
rm -rf build

cd
rm -rf $SYSTEMC_REPO_OUTDIR

echo "Done!"