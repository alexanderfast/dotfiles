#!/bin/bash -xe
if [[ -z "$(which nvim)" ]]; then
    sudo wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim.appimage -O /usr/local/bin/nvim
    sudo chmod +x /usr/local/bin/nvim
fi

if [[ ! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
