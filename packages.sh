#!/bin/sh

#add the yauort repository 
if ! grep -q archlinuxfr /etc/pacman.conf; then
    sudo sh -c 'echo "
[archlinuxfr]
SigLevel = Optional TrustAll
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf'
    sudo pacman -Syu
    yaourt -Syua # SHOULD be useless, but better safe than ...
fi

### CHECKOUT IF USEFUL: trayer
#xf86-video-nv or xf86-video-ati
# Packages which are needed for what is configured here
printf "What's your username you set this up for?"
read user
id -u $user &>/dev/null || useradd -m $user 

printf "Do you use 1) nvidia card or 2) ati card? (any other card: install drivers manually beforehand! press any other key to quit [1|2|q]"
read choice
shopt -s nocasematch
case "$choice" in
    1) 
    sudo pacman -S xf86-video-nvidia nvidia nvidia-utils
    sudo modprobe nvidia
    ;;
    2) 
    sudo pacman -S xf86-video-ati lib32-ati-dri
    sudo modprobe radeon
    *) exit
    
sudo pacman -S xorg-server xorg-xinit xorg-utils xorg-server-utils
sudo pacman -S rxvt-unicode feh dzen2 xmonad xmonad-contrib zsh git slim pkgfile pkgfile lxrandr wget goldendict bc yaourt fakeroot # -- needed
# Packages which I like or want in addition to the core
sudo pacman -S firefox chromium thunderbird pidgin pidgin-otr ntp flashplugin viewnior 
sudo chsh -s zsh $user

#packages from the AUR world:
#DISCLAIMER: Those packages are not official. I checked them and found nothing but that's worth just as much.
yaourt -S --noconfirm spotify command-not-found gtkclock gtk2-theme-solarizeddark-git grive cowfortune

#packages to take a closer look at:
#sudo pacman -S 
#yaourt -S compton

echo
echo "Do not forget to install: http://code.google.com/p/skype4pidgin/ ."
