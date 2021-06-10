urxvtd -o -q -f
xrdb -merge ~/.config/X11/.Xresources
xrandr --output eDP-1 --off --output HDMI-1 --primary --mode 3440x1440 --pos 0x0 --rotate normal
exec i3
