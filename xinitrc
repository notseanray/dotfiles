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
pulseaudio --daemonize=no --exit-idle-time=-1 &
/home/sean/.config/scripts/sbar.sh &
setwall $(cat /home/sean/.config/scripts/curwall)
exec dwm
#exec swim
