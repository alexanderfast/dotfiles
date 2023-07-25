#!/bin/bash -xe
if [[ -z "$(which nvim)" ]]; then
    mkdir -p ~/opensource/neovim
    git clone git@github.com:neovim/neovim.git ~/opensource/neovim
    cd ~/opensource/neovim
    git checkout v0.9.1
    make CMAKE_BUILD_TYPE=RelWithDebInfo
    sudo make install
fi

if [[ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
