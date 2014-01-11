#!/bin/sh

#add the yauort repository 
if ! grep -q archlinuxfr /etc/pacman.conf; then
    sudo sh -c 'echo "
[archlinuxfr]
SigLevel = Optional TrustAll
Server = http://repo.archlinux.fr/\$arch" >> /etc/pacman.conf'
    sudo pacman -Syu
fi

### CHECKOUT IF USEFUL: trayer
#xf86-video-nv or xf86-video-ati
# Packages which are needed for what is configured here
printf "What's your username you set this up for?"
read user
id -u $user &>/dev/null || useradd -m $user 

printf "Do you use 1) nvidia card or 2) ati card? (any other card: install drivers manually beforehand! press q to quit or any other key to continue. [1|2|q]"
read choice
shopt -s nocasematch
case "$choice" in
    1) 
    sudo pacman --needed -S xf86-video-nvidia nvidia nvidia-utils
    sudo modprobe nvidia
    ;;
    2) 
    sudo pacman --needed -S xf86-video-ati
    sudo modprobe radeon
    ;;
    q) exit;;
    *) echo "ok";;
esac    
sudo pacman -R vim
sudo pacman --needed -S xorg-server xorg-xinit xorg-utils xorg-server-utils
sudo pacman --needed -S rxvt-unicode feh dzen2 xmonad xmonad-contrib zsh git slim pkgfile pkgfile lxrandr wget goldendict bc yaourt fakeroot gvim transset-df  
# Packages which I like or want in addition to the core
sudo pacman --needed -S firefox chromium thunderbird pidgin pidgin-otr ntp flashplugin viewnior patch
udo chsh -s $(which zsh) $user 
yaourt -Syu
#packages from the AUR world:
#DISCLAIMER: Those packages are not official. I checked them and found nothing but that's worth just as much.
yaourt -S --noconfirm spotify command-not-found gtkclock gtk2-theme-solarizeddark-git grive cowfortune compton trayer-srg

#packages to take a closer look at:
#sudo pacman --needed -S 
#https://aur.archlinux.org/packages/shantz-xwinwrap-bzr/

echo
echo "Do not forget to install: http://code.google.com/p/skype4pidgin/ ."
