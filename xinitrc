#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

xrdb ~/.Xresources
xset m 1 0
xset -b
xsetroot -cursor_name left_ptr
xscreensaver -no-splash &
urxvtd -f
compton & 
unclutter -idle 5 -root &

if [ -e ~/.xinitrc_local ]; then
    ~/.xinitrc_local &
fi
(sleep 2&&trayer --edge top --align right --height 22 --heighttype pixel --margin 0 --SetDockType true --monitor 1 --widthtype pixel --width 240 --transparent true --alpha 0 --tint 0x1b1e1f&sleep 0.2&&volumeicon&fbxkb&)&

feh --bg-fill ~/.xmonad/res/bg/curve.jpg &
export BROWSER="firefox"

exec xmonad
export _JAVA_AWT_WM_NONREPARENTING=1
