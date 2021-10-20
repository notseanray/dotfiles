#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrandr --output DP-2 --mode 1920x1080 --rate 144.00 --primary
xrandr --output HDMI-0 --mode 1920x1080 --rotate left --left-of DP-2 --rate 60.00
xrandr --output DP-1 --mode 1920x1080 --right-of DP-2 --rate 60.00

xrdb /home/sean/.Xresources

xwallpaper --no-randr --focus /home/sean/.config/wallpapers/composite3.jpg

xset r rate 300 30

export TERM=xterm

#pulseaudio &

# test for an existing bus daemon, just to be safe
#if test -z "$DBUS_SESSION_BUS_ADDRESS" ; then
  # if not found, launch a new one
#  eval `dbus-launch --sh-syntax --exit-with-session`
#  echo "D-Bus per-session daemon address is: $DBUS_SESSION_BUS_ADDRESS"
#fi
#export DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host/run/dbus/system_bus_socket

#exec slstatus

exec dwm
# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
