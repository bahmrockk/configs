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
xsetroot -cursor_name left_ptr
xscreensaver -no-splash &
urxvtd -f
compton & 
pidgin &
firefox &
chromium &
thunderbird &
feh --bg-fill ~/.xmonad/res/bg/curve.jpg &
export BROWSER="firefox"

exec xmonad
