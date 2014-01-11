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
pidgin &
firefox &
chromium &
thunderbird &
if [ -e ~/.xinitrc_local ]; then
    ~/.xinitrc_local
fi

# trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true  --transparent true --alpha 256 --height 22 --heighttype pixel --margin 200 --SetDockType true --monitor 0 --widthtype pixel --tint 0x000000 &
feh --bg-fill ~/.xmonad/res/bg/curve.jpg &
export BROWSER="firefox"

exec xmonad
