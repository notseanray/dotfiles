# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#added by sean
alias sudo='doas'
alias rm='rm -v -I'
alias xi='sudo xbps-install'
alias xr='sudo xbps-remove'
alias xq='xbps-query'
alias ll='exa --long --header'
#alias discord='/usr/share/Discord/Discord &'
alias ss="scrot -s ~/Desktop/temp.png"
#alias mc="~/Desktop/MC/MultiMC/MultiMC &"

export TERM=xterm
export TERMINAL=urxvt
export EDITOR=nvim
#export BROWSER=brave-browser.desktop

export CLR_OPENSSL_VERSION_OVERRIDE=46

#xdg-settings set default-web-browser brave-browser.desktop
xdg-mime default brave-browser.desktop x-scheme-handler/https x-scheme-handler/http

alias ls='ls --color=auto'
PS1="\[\033[01;32m\]\u\\[\033[01;91m\]@\[\033[01;35m\]\h\[\033[01;30m\]\w\[\033[94m\]$ "

#less -FX /home/sean/.config/wallpapers/consoleart.txt

uptime -p

# Android tools
export PATH=${PATH}:/home/sean/Desktop/stuff/platform-tools
. "$HOME/.cargo/env"

#auto complete
#source /usr/share/bash-completion/bash_completion

