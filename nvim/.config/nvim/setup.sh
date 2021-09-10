#! /usr/bin/env bash

# Install vim plug on your system
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Install node.js for coc
curl -sL install-node.now.sh/lts | bash
