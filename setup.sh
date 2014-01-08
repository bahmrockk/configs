#!/bin/bash

SELFNAME=$(readlink -f $0)
SELFPATH=$(dirname $SELFNAME)

printf "This will permanently overwrite existing configurations and replace them with links to the current location for this repository. Are you REALLY sure you know what you do\n?"
printf "There is no package check. If you don't have what I use, you're screwed.\n"
printf "Please be adviced that answering 'no' is a sign of strength, not of weakness! [yes|no] "
read choice
shopt -s nocasematch
case "$choice" in
    yes)
        rm -f ~/.xscreensaver
        ln -s $SELFPATH/xscreensaver ~/.xscreensaver
        rm -f ~/.Xresources
        ln -s $SELFPATH/Xresources ~/.Xresources
        rm -f ~/.vimrc
        ln -s $SELFPATH/vimrc ~/.vimrc
        rm -f ~/.zshrc
        ln -s $SELFPATH/zshrc ~/.zshrc
        rm -rf ~/.xmonad
        ln -s $SELFPATH/xmonad ~/.xmonad
        rm -rf ~/.xinitrc
        ln -s $SELFPATH/xinitrc ~/.xinitrc
        rm -rf ~/.config/vim/
        ln -s $SELFPATH/vim/ ~/.config/
        mkdir -p ~/.cache/zsh/
        $SELFPATH/dir_structure.sh
        $SELFPATH/packages.sh 
        printf "\ndone. You're now 20%% cooler. Good luck finding errors!\n"
        ;;
    *) printf "\nthought so. Pussy. $SELFPATH \n" echo $SELFPATH;;
esac
