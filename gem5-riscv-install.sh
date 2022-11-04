#!/bin/bash

# Check if "apt-fast" is installed as preferred package manager. If it is, use it as APT_COMMAND.
if [ -x "$(command -v apt-fast)" ]; then
    APT_COMMAND="apt-fast"
else
    APT_COMMAND="apt-get"
fi

script_id="gem5-riscv-install"
gem5_repository="https://gem5.googlesource.com/public/gem5"
actual_dir=$(pwd)
cpu_count=$(grep -c ^processor /proc/cpuinfo)
echo -e "Got CPU count: $cpu_count"

# Write install code here
echo -e "Installing pre-requisites..."
sudo $APT_COMMAND install -y build-essential git m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev python-dev python
sudo $APT_COMMAND install -y git build-essential scons python-dev libprotobuf-dev python-protobuf protobuf-compiler libgoogle-perftools-dev libboost-all-dev automake

echo -e "Cloning gem5 repository and building a RISC-V optimized binary..."
git clone https://gem5.googlesource.com/public/gem5
cd ./gem5
scons build/RISCV/gem5.opt --ignore-style -j$cpu_count

cd $actual_dir
echo -e "Done!"
