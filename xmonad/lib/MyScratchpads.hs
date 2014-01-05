module MyScratchpads where

import XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad

-- format & inspiration found @ http://pbrisbin.com/tags/xmonad/
myScratchpads = [
     NS "goldendict" "goldendict" (className =? "Goldendict") defaultFloating
--         (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)) ,
    ,NS "notes" spawnTerm  findTerm  manageTerm       -- and a second
    ] 
    where
        spawnTerm  = "~/.xmonad/scripts/gvim-scratchpad"       -- launch my terminal
        findTerm   = stringProperty "WM_WINDOW_ROLE" =? "notes"
        manageTerm = customFloating $ W.RationalRect l t w h -- and I'd like it fixed using the geometry below
            where
                h = 0.3       
                w = 0.3      
                t = (1-h)/2 
                l = (1-w)/2
