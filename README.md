# dotfiles

Used together with [nixos-flake](https://github.com/alexanderfast/nixos-flake/).

```bash
git clone --recurse-submodules -j8 https://github.com/alexanderfast/dotfiles ~/.dotfiles
cd ~/.dotfiles
stow -Rv .
tmux new zsh
```

Assumes [powerline fonts](https://github.com/powerline/fonts) are installed.

## Todo

- Better vi mode in zsh.
- Header symbol in i3 and tmux.
