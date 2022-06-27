#!/bin/sh
feh --bg-scale /home/howard/Pictures/wallpaper/wallpaper-master/arch.png
picom & disown # --experimental-backends --vsync should prevent screen tearing on most setups if needed
barrier &
dunst &
fcitx5 &
udiskie -t &
blueman-applet &

# Low battery notifier
~/.config/qtile/scripts/check_battery.sh & disown

# Start welcome
eos-welcome & disown

/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & disown # start polkit agent from GNOME
