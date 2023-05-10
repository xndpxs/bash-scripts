#!/bin/bash
get_knumber=$(kscreen-doctor -o | grep @240 | awk '{print $2}' | sed 's/\x1B\[[0-9;]*[mG]//g')
kscreen-doctor output.$get_knumber.mode.1920x1080@240
