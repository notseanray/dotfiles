# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

export TERM='xterm-256color'
xset r rate 300 30
alias sudo='doas'
export TERM="st"
export TERMINAL="st"
export terminal="st"
export COLORTERM="truecolor"
alias rm='rm -v -I'
alias ll='exa --long --header'
alias grep='rg'
alias find='fd'
export _JAVA_AWT_WM_NONREPARENTING=1
alias ls='ls --color=auto'
alias sd="nsxiv"
export PATH=${PATH}:/home/sean/.config/scripts

PS1="\\[\033[36m\]\u@\h \\[\033[90m\]\w \\[\033[37m\]$ "
. "$HOME/.cargo/env"
