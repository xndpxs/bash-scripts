#!/bin/bash
#
# Detectar si estamos en X11 o en Wayland
if [ "$XDG_SESSION_TYPE" = "x11" ]; then
    # Estamos en X11
    get_knumber=$(kscreen-doctor -o | grep @240 | awk '{print $2}' | sed 's/\x1B\[[0-9;]*[mG]//g')
    kscreen-doctor output.$get_knumber.mode.1920x1080@240
else
    # Estamos en Wayland
    get_knumber=$(kscreen-doctor -o | grep @240 | awk '{print $2}' | sed 's/\x1B\[[0-9;]*[mG]//g')
    kscreen-doctor output.$get_knumber.mode.1920x1080@240
fi
