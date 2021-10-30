#!/bin/bash

# for compiling vim on ubuntus that dont yet have 0.5.x

branch=v0.5.1
workdir=/tmp/neovim

git clone git@github.com:neovim/neovim.git --branch $branch --single-branch $workdir
pushd $workdir
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
make CMAKE_BUILD_TYPE=Release -j4
sudo make install
popd
