# Created by newuser for 5.9

#------------------------------
# Make colors work in zsh
#------------------------------
autoload -U colors && colors

# Colored man
# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}


#------------------------------
# History in cache directory:
#------------------------------
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.cache/zsh/history

#------------------------------
# Basic auto/tab complete:
#------------------------------
autoload -U compinit promptinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
promptinit


#------------------------------
# Vim bindings
#------------------------------
bindkey -v
bindkey -s jk '\e'
bindkey -s kj '\e'
bindkey "^?" backward-delete-char
bindkey -M menuselect '^[[Z' reverse-menu-complete
KEYTIMEOUT=2

#------------------------------
# fzf utility
#------------------------------
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

#------------------------------
# plugins
#------------------------------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="nvim"

#------------------------------
# Alisa
#------------------------------
alias ls="exa"
alias ll="exa --long --all"
alias cat="bat"
alias c="clear"
alias r="ranger"
alias s="source ~/.config/zsh/.zshrc"

# Conda support
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# Prompt them
eval "$(starship init zsh)"
