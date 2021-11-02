#!/bin/bash
#set -e
configurations=(conky i3 zsh compton.conf terminator sway dunst waybar alacritty )
echo "You are about to remove the following configuration folders, plus the nvim config files:"
for i in ${configurations[@]}; do
    echo $i
done
read -p "Do you want to proceed? [yes|anything]
" yn #linebreak for "read"
case $yn in
    yes) 
        for i in ${configurations[@]}; do
            ln -sf $(pwd)/$i ~/.config/$i
        done
        ;; 
    *) echo "no";;
esac
#ln -sf ./conky ~/config/conky

ln -sf $(pwd)/nvim/* ~/.config/nvim/
