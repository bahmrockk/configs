#!/bin/sh
# adaption of example script: https://www.haskell.org/haskellwiki/Xmonad/General_xmonad.hs_config_tips#Displaying_keybindings_with_dzen2

fgCol=green4
bgCol=black
titleCol=green4
commentCol=slateblue
keyCol=green2
XCol=orange3
startLine=3
( echo "   ^fg($titleCol) ----------- keys -----------^fg()";
  egrep 'xK_|eys' ~/.xmonad/lib/MyKeyBindings.hs | tail -n +$startLine \
          | sed -e 's/\( *--\)\(.*eys*\)/\1^fg('$commentCol')\2^fg()/' \
                    -e 's/((\(.*xK_.*\)), *\(.*\))/^fg('$keyCol')\1^fg(), ^fg('$XCol')\2^fg()/'                                                                                
    echo '^uncollapse()';
    echo '^stick()';
    echo '^scrollhome()' ) | dzen2 -fg $fgCol -bg $bgCol -x 700 -y 300 -l 22 -ta c -sa l -w 900 -p 2 -xs 1  
