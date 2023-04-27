#!/bin/bash

if [ -n "$(grep 'Arch Linux' /etc/os-release)" ]; then
	# extra packages only for deskop
	sudo pacman -Sq --noconfirm picom

	# greeter
	sudo pacman -Sq --noconfirm lightdm lightdm-gtk-greeter
	sudo systemctl enable lightdm.service
	sudo cp -f ~/.dotfiles/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
	sudo mkdir -p /etc/share/pixmaps
	sudo cp ~/.dotfiles/wallpapers/cubes.png /etc/share/pixmaps/cubes.png

	# enable ntp, why isnt this default?
	timedatectl set-ntp true
elif [ -z "$(grep 'Arch Linux' /etc/os-release)" ]; then
	sudo dnf copr enable -y frostyx/qtile
	sudo dnf install -y alacritty qtile xrandr dunst
else
fi
