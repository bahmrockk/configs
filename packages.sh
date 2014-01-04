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


# Packages which are needed for what is configured here
sudo pacman -S dzen2 xmonad xmonad-contrib zsh git slim pkgfile pkgfile lxrandr wget goldendict # -- needed
# Packages which I like or want in addition to the core
sudo pacman -S firefox chromium thunderbird pidgin pidgin-otr playonlinux steam ntp yaourt flashplugin

#the new repository has to be loaded potentially
#get yauort and dependencies from repository

#packages from the AUR world:
#yaourt -S --noconfirm spotify command-not-found gtkclock gtk2-theme-solarizeddark-git

#packages to take a closer look at:
#sudo pacman -S 
