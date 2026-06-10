#!/bin/bash
case "$1" in
    up) amixer set Master 5%+ > /dev/null ;;
    down) amixer set Master 5%- > /dev/null ;;
    toggle) amixer set Master toggle > /dev/null ;;
esac
if [ "$1" ]; then exit 0; fi
VOL=$(amixer get Master | grep -oP '\d+(?=%)' | head -1)
MUTE=$(amixer get Master | grep -oP '\[(on|off)\]' | head -1)
if [ "$MUTE" = "[off]" ]; then
    echo " ${VOL}%"
else
    if [ "$VOL" -le 30 ]; then echo " ${VOL}%"
    elif [ "$VOL" -le 70 ]; then echo " ${VOL}%"
    else echo " ${VOL}%"; fi
fi
