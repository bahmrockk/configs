#!/bin/sh
process() {
	while read line; do 
		case "$line" in
			UNBLANK*)
 				feh --bg-max --randomize --no-fehbg ~/Nextcloud/Wallpaper/* 
			;;
			BLANK*)
			;;
			RUN*)
			;;
			LOCK*)
			;;
		esac
	done
}

xscreensaver-command -watch | process
