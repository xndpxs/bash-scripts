#!/bin/bash


if [[ $XDG_CURRENT_DESKTOP == "KDE" ]]; then

get_knumber=$(kscreen-doctor -o | grep @240 | awk '{print $2}' | sed 's/\x1B\[[0-9;]*[mG]//g')
kscreen-doctor output.$get_knumber.mode.1920x1080@240

else

get_gnumber=$(gnome-randr query | grep -B 2 "@240" | awk 'NR==2{print $1}'|sed 's/\x1B\[[0-9;]*[mG]//g')
gnome-randr modify $get_gnumber --mode 1920x1080@240.000

fi