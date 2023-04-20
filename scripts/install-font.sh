#!/bin/bash -xe

fontdir=~/.local/share/fonts
mkdir -p $fontdir
wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/Hack.zip -O $fontdir/hack.zip
unzip -o $fontdir/hack.zip -d $fontdir
fc-cache $fontdir
