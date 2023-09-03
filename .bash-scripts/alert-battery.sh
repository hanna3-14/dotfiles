#!/bin/bash
bat_files="/sys/class/power_supply/BAT0"
bat_status=$(cat "${bat_files}/status")
capacity=$(cat "${bat_files}/capacity")
if [[ "${bat_status}" == "Discharging" && ${capacity} -le 10 ]]; then
	notify-send --urgency=CRITICAL \
		--icon=${HOME}/.config/pictures/sad.jpg \
		"I am reeeeeeeeally hungry" \
		"Only ${capacity}% battery remaining"
elif [[ "${bat_status}" == "Discharging" && ${capacity} -le 20 ]]; then
	notify-send --urgency=CRITICAL \
		--icon=${HOME}/.config/pictures/low_battery.png \
		"I am hungry, give me electricity" \
		"Only ${capacity}% battery remaining"
fi

