# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#added by sean
alias sudo='doas'
alias rm='rm -v -I'
alias xi='doas xbps-install'
alias xr='doas xbps-remove'
alias xq='xbps-query'
alias ll='exa --long --header'
alias grep='rg'
alias ss="scrot -s ~/Desktop/temp.png"
alias lvim="/home/sean/.local/bin/lvim"
alias nvim="lvim"

export TERM="xterm"
export TERMINAL="urxvt"
export EDITOR="lvim" 
export BROWSER="firefox"
export COLORTERM="truecolor"

export CLR_OPENSSL_VERSION_OVERRIDE=46

xdg-mime default brave-browser.desktop x-scheme-handler/https x-scheme-handler/http

alias ls='ls --color=auto'
PS1="\[\033[01;32m\]\u\\[\033[01;91m\]@\[\033[01;35m\]\h\[\033[01;30m\]\w\[\033[94m\]$ "

# Android tools
export PATH=${PATH}:/home/sean/Desktop/stuff/platform-tools
. "$HOME/.cargo/env"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#export PATH=${PATH}:/home/sean/Desktop/stuff/speech-text-rs
#export LD_LIBRARY_PATH="/home/sean/Desktop/stuff/seanspeech/native_client"
#export LIBRARY_PATH="/home/sean/Desktop/stuff/seanspeech/native_client"
term=xterm
xset r rate 300 30
