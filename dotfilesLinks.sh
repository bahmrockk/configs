#!/bin/bash
#set -e
dotfiles=(zshenv Xdefaults vim vimrc)
echo "You are about to remove the following configuration folders:"
for i in ${dotfiles[@]}; do
    echo $i
done
read -p "Do you want to proceed? [yes|anything]
" yn #linebreak for "read"
case $yn in
    yes) 
        for i in ${dotfiles[@]}; do
            ln -sf $(pwd)/dotfiles/$i ~/.$i
        done
        ;; 
    *) echo "no";;
esac
#ln -sf ./conky ~/config/conky
