#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?* ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrandr --output DP-2 --mode 1920x1080 --rate 144.00 --primary
xrandr --output HDMI-0 --mode 1920x1080 --rate 60.00 --rotate left --left-of DP-2 --rate 60.00
xrandr --output DP-1 --mode 1920x1080 --right-of DP-2 --rate 60.00

xrdb /home/sean/.config/Xresources &
xrdb -merge /home/sean/.config/Xdefaults &
. "$HOME/.config/bashrc"
unset XDG_RUNTIME_DIR
export XDG_RUNTIME_DIR=$(mktemp -d /tmp/$(id -u)-runtime-dir.XXX)
killall pulseaudio
killall picom
killall dunst
# there should be no errors, so we can simply just yeet all output
# I will save the dwm log because if that crashes then something is very wrong 
pulseaudio --daemonize=no --exit-idle-time=-1 > /dev/null 2>&1 &
picom -b > /dev/null 2>&1 &
dunst > /dev/null 2>&1 &
/home/sean/.config/scripts/sbar.sh > /dev/null 2>&1 &
setwall $(cat /home/sean/.config/scripts/curwall)
/home/sean/eth.sh &
exec dwm > ~/.local/share/dwm.log
