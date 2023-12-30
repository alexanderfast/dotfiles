#!/bin/bash -xe
if [[ -z "$(which nvim)" ]]; then
    mkdir -p ~/opensource/neovim
    git clone git@github.com:neovim/neovim.git ~/opensource/neovim
    cd ~/opensource/neovim
    git checkout v0.9.5
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
fi
