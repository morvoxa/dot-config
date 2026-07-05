#!/bin/bash

INTERFACE="wlp0s29u1u1"

OLD_RX=$(cat /proc/net/dev | grep "$INTERFACE" | awk '{print $2}')
OLD_TX=$(cat /proc/net/dev | grep "$INTERFACE" | awk '{print $10}')

while true; do
	sleep 1

	NOW_RX=$(cat /proc/net/dev | grep "$INTERFACE" | awk '{print $2}')
	NOW_TX=$(cat /proc/net/dev | grep "$INTERFACE" | awk '{print $10}')

	[ -z "$NOW_RX" ] && NOW_RX=$OLD_RX
	[ -z "$NOW_TX" ] && NOW_TX=$OLD_TX

	DOWN=$(((NOW_RX - OLD_RX) / 1024))
	UP=$(((NOW_TX - OLD_TX) / 1024))

	if [ $DOWN -gt 1024 ]; then
		DOWN_STR=$(echo "scale=1; $DOWN / 1024" | bc)M/s
	else
		DOWN_STR="${DOWN}K/s"
	fi

	if [ $UP -gt 1024 ]; then
		UP_STR=$(echo "scale=1; $UP / 1024" | bc) /s
	else
		UP_STR="${UP}K/s"
	fi

	TIME=$(date +'%H:%M')

	xsetroot -name " ⬇️ $DOWN_STR ⬆️ $UP_STR | 🕒 $TIME "

	OLD_RX=$NOW_RX
	OLD_TX=$NOW_TX
done &

feh --bg-scale ~/Downloads/sebastian-schuster-4a-5UoXRv_o-unsplash.jpg &

exec dwm
