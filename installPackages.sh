#!/bin/sh
pacman -S git
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
cd ..
rm -rf ./trizen
trizen -S --needed - < ./packageList.txt
