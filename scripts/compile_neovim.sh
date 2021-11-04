#!/bin/bash

# for compiling vim on ubuntus that dont yet have 0.5.x

branch=v0.5.1
workdir=/tmp/neovim

if [ $(which nvim) ]; then
    echo 'nvim already install, exiting'
    exit 0
fi

git clone https://github.com/neovim/neovim --branch $branch --single-branch $workdir
pushd $workdir
sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
make CMAKE_BUILD_TYPE=Release -j4
sudo make install
popd
