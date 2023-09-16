#!/bin/bash -xe

branch=v0.9.2
workdir=$HOME/src/neovim

if [ $(which nvim) ]; then
	echo 'nvim already install, exiting'
	exit 0
fi
if [ -d "$workdir" ]; then
	pushd $workdir
	git fetch --prune
	git checkout $branch
else
	git clone https://github.com/neovim/neovim $workdir
	pushd $workdir
	git checkout $branch
fi

if [ -n "$(grep 'Ubuntu' /etc/os-release)" ]; then
	sudo apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
	make CMAKE_BUILD_TYPE=Release -j4
	sudo make install
	popd
elif [ -n "$(grep 'Debian' /etc/os-release)" ]; then
	sudo apt install build-essential cmake gettext
	make CMAKE_BUILD_TYPE=RelWithDebInfo -j4 CMAKE_INSTALL_PREFIX=$HOME/.local
	make install
	popd
fi
