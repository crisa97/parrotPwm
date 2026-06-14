#!/bin/bash
WID=$(bspc query -N -n focused)
STATE=$(bspc query -T -n "$WID" | grep -oP '"state":\s*"\K[^"]+')
if [ "$STATE" = "fullscreen" ]; then
    bspc node "$WID" -t tiled
fi
