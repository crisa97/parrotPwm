#!/bin/bash
killall picom 2>/dev/null
i3lock-color -i ~/.config/i3lock/lock.png -n
picom --no-use-damage -b & disown
