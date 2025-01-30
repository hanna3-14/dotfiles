#!/bin/bash

BRIGHTNESS="$(ddcutil getvcp 10 | grep -oP 'current value =\s*\K\d+')"

ICONS=(
		""
		""
		""
		""
		""
		""
		""
		""
		""
)

if [ "$BRIGHTNESS" -lt 10 ]; then
		ICON="${ICONS[0]}"
elif [ "$BRIGHTNESS" -lt 20 ]; then
		ICON="${ICONS[1]}"
elif [ "$BRIGHTNESS" -lt 30 ]; then
		ICON="${ICONS[2]}"
elif [ "$BRIGHTNESS" -lt 40 ]; then
		ICON="${ICONS[3]}"
elif [ "$BRIGHTNESS" -lt 50 ]; then
		ICON="${ICONS[4]}"
elif [ "$BRIGHTNESS" -lt 60 ]; then
		ICON="${ICONS[5]}"
elif [ "$BRIGHTNESS" -lt 70 ]; then
		ICON="${ICONS[6]}"
elif [ "$BRIGHTNESS" -lt 80 ]; then
		ICON="${ICONS[7]}"
else
		ICON="${ICONS[8]}"
fi

echo "$BRIGHTNESS% $ICON"
