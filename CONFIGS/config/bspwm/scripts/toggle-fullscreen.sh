#!/bin/bash
WID=$(xdotool getactivewindow)
STATE=$(bspc query -T -n "$WID" | grep -oP '"state":\s*"\K[^"]+')
if [ "$STATE" = "fullscreen" ]; then
    bspc node "$WID" -t tiled
else
    bspc node "$WID" -t floating
    xdotool windowsize "$WID" 1920 1032
    xdotool windowmove "$WID" 0 48
fi
