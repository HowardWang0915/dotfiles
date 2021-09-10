#! /usr/bin/env bash

# Install vim plug on your system
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install node.js for coc
yay -S nodejs npm

# run pluginstall from the terminal
nvim +'PlugInstall --sync' +qa
