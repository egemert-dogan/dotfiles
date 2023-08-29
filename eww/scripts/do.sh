#!/bin/bash

if [[ -z "$1" || "$1" == "help" ]]; then
	echo "Available: toggle_music, music, system"
elif [[ "$1" == "music" ]]; then
	if [[ "$2" == "name" ]]; then
		mpc current -f '%title% - %artist%'
	elif [[ "$2" == "progress" ]]; then
		mpc status | grep "%)" | awk '{print $4}' | tr -d '(%)'
	elif [[ "$2" == "toggle" ]]; then
		mpc -q toggle
	elif [[ "$2" == "next" ]]; then
		mpc -q next
	elif [[ "$2" == "prev" ]]; then
		mpc -q prev
	elif [[ -z "$2" || "$2" == "help" ]]; then
		echo "Available: name, progress, toggle, next, prev"
	fi
elif [[ "$1" == "system" ]]; then
	if [[ "$2" == "cpu" ]]; then
		python -c "import psutil; print(float(round(psutil.cpu_percent(1),0) + 4))"
	elif [[ "$2" == "disk" ]]; then
		python -c "import psutil; print(str(psutil.disk_usage('/home').percent))"
	elif [[ "$2" == "mem" ]]; then
		python -c "import psutil; print(str(round(psutil.virtual_memory().percent,0)))"
	elif [[ "$2" == "title" ]]; then
		xdotool getwindowfocus getwindowname
	elif [[ "$2" == "vol" ]]; then
		pamixer --get-volume
	elif [[ -z "$2" || "$2" == "help" ]]; then
		echo "Available: cpu, disk, mem, title, vol, workspace"
	fi
elif [[ "$1" == "keyboard" ]]; then
	if [[ "$2" == "layout" ]]; then
		hyprctl devices | grep 'active keymap:' | sed -n '4p' | awk '{print $3}'
	elif [[ "$2" == "change" ]]; then
		# 0 = us
		# 1 = tr
		# 2 = tr,ku
		hyprctl  switchxkblayout semico---usb-gaming-keyboard- "$3"
	fi
fi
