#!/bin/sh
pacman -S git
git clone https://aur.archlinux.org/trizen.git
cd trizen
makepkg -si
cd ..
rm -r trizen
trizen -S - < ./packageList.txt
