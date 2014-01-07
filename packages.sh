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

# Packages which are needed for what is configured here
sudo pacman -S dzen2 xmonad xmonad-contrib zsh git slim pkgfile pkgfile lxrandr wget goldendict bc yaourt # -- needed
# Packages which I like or want in addition to the core
sudo pacman -S firefox chromium thunderbird pidgin pidgin-otr playonlinux steam ntp flashplugin viewnior 
sudo chsh -s zsh bahmrockk

#packages from the AUR world:
#DISCLAIMER: Those packages are not official. I checked them and found nothing but that's worth just as much.
yaourt -S --noconfirm spotify command-not-found gtkclock gtk2-theme-solarizeddark-git grive cowfortune

#packages to take a closer look at:
#sudo pacman -S 

echo
echo "Do not forget to install: http://code.google.com/p/skype4pidgin/ ."
