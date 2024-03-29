#!/bin/bash

if [ -n "$(grep 'fedora' /etc/os-release)" ]; then
	sudo dnf install -y zsh tmux neovim gcc-c++ ripgrep openconnect openssh
	sudo dnf groupinstall -y 'Development Tools'
elif [ -n "$(grep 'Arch Linux' /etc/os-release)" ]; then
	sudo pacman -Sq --noconfirm git zsh tmux python3 cmake make base-devel openssh bitwarden wget curl unzip neovim ripgrep pyright npm ttf-hack-nerd

	# enable ntp, why isnt this default?
	timedatectl set-ntp true
elif [ -n "$(grep 'Ubuntu' /etc/os-release)" ]; then
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
elif [ -n "$(grep 'Debian' /etc/os-release)" ]; then
	sudo apt install git zsh tmux python3 python3-pygment cmake build-essential wget curl
fi
