#!/bin/bash
WID=$(xdotool getactivewindow)
DIR=$1

MONINFO=$(bspc query -T -m focused)
MONW=$(echo "$MONINFO" | jq -r '.rectangle.width')
MONH=$(echo "$MONINFO" | jq -r '.rectangle.height')
MONX=$(echo "$MONINFO" | jq -r '.rectangle.x')
MONY=$(echo "$MONINFO" | jq -r '.rectangle.y')
PADDING=48

case "$DIR" in
    west)
        X=$MONX; Y=$((MONY + PADDING)); W=$((MONW / 2)); H=$((MONH - PADDING))
        ;;
    east)
        X=$((MONX + MONW / 2)); Y=$((MONY + PADDING)); W=$((MONW / 2)); H=$((MONH - PADDING))
        ;;
    north)
        X=$MONX; Y=$((MONY + PADDING)); W=$MONW; H=$((MONH / 2))
        ;;
    south)
        X=$MONX; Y=$((MONY + MONH / 2 + PADDING)); W=$MONW; H=$((MONH / 2))
        ;;
esac

CUR=$(xdotool getwindowgeometry --shell "$WID" 2>/dev/null)
CUR_X=$(echo "$CUR" | grep "^X=" | cut -d= -f2)
CUR_Y=$(echo "$CUR" | grep "^Y=" | cut -d= -f2)
CUR_W=$(echo "$CUR" | grep "^WIDTH=" | cut -d= -f2)
CUR_H=$(echo "$CUR" | grep "^HEIGHT=" | cut -d= -f2)

if [ "$CUR_X" = "$X" ] && [ "$CUR_Y" = "$Y" ] && [ "$CUR_W" = "$W" ] && [ "$CUR_H" = "$H" ]; then
    bspc node "$WID" -t tiled
else
    bspc node "$WID" -t floating
    xdotool windowmove "$WID" "$X" "$Y"
    xdotool windowsize "$WID" "$W" "$H"
fi
