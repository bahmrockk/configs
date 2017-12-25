#!/bin/bash
#set -e
configurations=(conky i3 zsh compton.conf terminator)
echo "You are about to remove the following configuration folders:"
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
