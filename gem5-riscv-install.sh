#!/bin/bash

script_id="gem5-riscv-install"
gem5_repository="https://gem5.googlesource.com/public/gem5"
actual_dir=$(pwd)
cpu_count=$(grep -c ^processor /proc/cpuinfo)
echo -e "Got CPU count: $cpu_count"

# Write install code here
echo -e "Installing pre-requisites..."
sudo apt install -y build-essential git m4 scons zlib1g zlib1g-dev libprotobuf-dev protobuf-compiler libprotoc-dev libgoogle-perftools-dev python-dev python
sudo apt install -y git
sudo apt install -y build-essential
sudo apt install -y scons
sudo apt install -y python-dev
sudo apt install -y libprotobuf-dev python-protobuf protobuf-compiler libgoogle-perftools-dev
sudo apt install -y libboost-all-dev
sudo apt install -y automake

echo -e "Cloning gem5 repository and building a RISC-V optimized binary..."
git clone https://gem5.googlesource.com/public/gem5
cd ./gem5
scons build/RISCV/gem5.opt -j$cpu_count

cd $actual_dir
echo -e "Done!"