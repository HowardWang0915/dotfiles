#!/bin/bash
yay -S stow lsd bat fzf tmux neovim trash-cli
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode \
	  $ZSH/custom/plugins/zsh-vi-mode
