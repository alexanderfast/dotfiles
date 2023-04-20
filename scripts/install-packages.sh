#!/bin/bash

if [ -z "$(grep 'Arch Linux' /etc/os-release)" ]
then
	# if empty assume ubuntu
	# ripgrep isnt in apt before v20
	major=$(lsb_release -r | grep Release | grep -oP '\d+\.\d+' | cut -d'.' -f1)
	set -xe
	if [ "$major" -gt 18 ]; then
	    sudo apt install -y ripgrep
	else
	    version=13.0.0
	    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/$version/ripgrep_${version}_amd64.deb
	    sudo dpkg -i ripgrep_${version}_amd64.deb
	fi

	sudo apt-get install -y git zsh tmux python3 fonts-powerline cmake make fuse build-essential
else
	sudo pacman -Sy git zsh tmux python3 cmake make base-devel openssh bitwarden wget curl fuse unzip neovim ripgrep picom pyright npm
fi
