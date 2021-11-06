# primary 144hz display
xrandr --output DP-2 --mode 1920x1080 --rate 144.00 --primary
#portrait monitor
xrandr --output HDMI-0 --mode 1920x1080 --rotate left --left-of DP-2 --rate 60.00
#lg other monitor
xrandr --output DP-1 --mode 1920x1080 --right-of DP-2 --rate 60.00
