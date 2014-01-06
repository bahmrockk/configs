module MyScratchpads where

import XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad

-- format & inspiration found @ http://pbrisbin.com/tags/xmonad/
myScratchpads = [
     NS "goldendict" "goldendict" (className =? "Goldendict") placeWin 
    ,NS "notes" spawnGvim  findGvim placeWin 
    ] 
    where
        spawnGvim  = "~/.xmonad/scripts/gvim_scratchpad.sh"       -- launch my terminal
        findGvim   = stringProperty "WM_WINDOW_ROLE" =? "notes"
        placeWin   = customFloating $ W.RationalRect l t w h -- and I'd like it fixed using the geometry below
            where
                h = 0.3       
                w = 0.3      
                t = (1-h)/2 
                l = (1-w)/2
