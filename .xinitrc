#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrandr --output DP-2 --mode 1920x1080 --rate 144.00 --primary
xrandr --output HDMI-0 --mode 1920x1080 --rotate left --left-of DP-2 --rate 60.00
xrandr --output DP-1 --mode 1920x1080 --right-of DP-2 --rate 60.00

xrdb /home/sean/.Xresources &

xwallpaper --no-randr --focus /home/sean/.config/wallpapers/composite4.jpg &

pulseaudio &
/home/sean/.config/sbar &

exec dwm
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
