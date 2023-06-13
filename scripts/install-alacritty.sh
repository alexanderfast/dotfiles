#!/bin/bash
workdir=/tmp/alacritty

mkdir -p $workdir
sudo apt install cmake pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3 -y
sudo curl https://sh.rustup.rs -sSf | sh
git clone https://github.com/jwilm/alacritty.git $workdir
pushd $workdir
#git checkout v0.12.1
cargo build --release
sudo cp target/release/alacritty /usr/local/bin
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
