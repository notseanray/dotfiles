export PATH=${PATH}:/home/sean/.config/scripts
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then exec startx; fi
