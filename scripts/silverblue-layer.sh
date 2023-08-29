#!/bin/bash
# consider running 'rpm-ostree reset' first
#
# These are compiler packages, mostly needed to get neovim plugin
# 'gcc-c++' autoconf automake binutils bison flex gcc gdb glibc-devel libtool make
#
# These are the dev environment, zsh tmux and nvim (TODO move these to distrobox)
# fzf neovim npm python3-pygments tmux util-linux-user vim zsh
#
# These are extra:
# distrobox kitty
rpm-ostree install 'gcc-c++' autoconf automake binutils bison distrobox flex fzf gcc gdb glibc-devel kitty langpacks-en libtool make neovim npm python3-pygments tmux util-linux-user vim zsh
