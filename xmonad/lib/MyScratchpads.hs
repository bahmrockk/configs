module MyScratchpads where

import XMonad.StackSet as W
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad

-- format & inspiration found @ http://pbrisbin.com/tags/xmonad/
myScratchpads = [
     NS "stardict" "stardict" (className =? "Stardict") defaultFloating
--         (customFloating $ W.RationalRect (1/6) (1/6) (2/3) (2/3)) ,
     ,NS "notes" spawnTerm  findTerm  manageTerm       -- and a second
    ] 
    where
        spawnTerm  = "xterm -name notes"       -- launch my terminal
        findTerm   = resource  =? "notes"               -- its window will be named "scratchpad" (see above)
        manageTerm = customFloating $ W.RationalRect l t w h -- and I'd like it fixed using the geometry below
            where
                h = 0.2       
                w = 0.5      
                t = 1 - h   
                l = (1 - w)/2
