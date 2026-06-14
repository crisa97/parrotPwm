#!/bin/bash
WID=$(xdotool search --class dropdown 2>/dev/null | head -1)
if [ -n "$WID" ]; then
    if bspc query -N -n "$WID.hidden" &>/dev/null; then
        bspc node "$WID" -g hidden=off
        bspc node "$WID" -f
    else
        bspc node "$WID" -g hidden=on
    fi
else
    kitty --class dropdown &
fi
