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

script_id="gem5-riscv-install"
actual_dir=$(pwd)

# Prepare constants and variables
make_title "Preparing constants and variables..."
gem5_repository="https://gem5.googlesource.com/public/gem5"
cpu_count=$(grep -c ^processor /proc/cpuinfo)
echo -e "Got CPU count: $cpu_count"

# Install pre-requisites
make_title "Installing pre-requisites..."
sudo $APT_COMMAND install -y build-essential git m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev python-dev python3 python3-dev python3-venv libboost-all-dev automake

make_title "Cloning gem5 repository and building a RISC-V optimized binary..."
git clone https://gem5.googlesource.com/public/gem5
cd ./gem5
scons build/RISCV/gem5.opt --ignore-style -j$cpu_count

cd $actual_dir
echo -e "Done!"
