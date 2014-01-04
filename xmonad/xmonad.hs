import XMonad
import XMonad.Util.Run -- spawnPipe
import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedScratchpad
--import XMonad.Hooks.FadeInactive
--import XMonad.Layout.IndependentScreens


-- data manipulation
--import qualified Data.Map        as M
-- WS management
--import XMonad.Actions.CycleWS

--import Graphics.X11.Xinerama

import MyKeyBindings
import MyHooks -- myManageHook, myLogHook, myUrgencyHookC
import MyWorkspaces
import MyLayout
import MyBars -- bars and popup bars
import MyScratchpads
-- bar = dzenXMonadBar
--barColors = DzenBar {
--    MyBars.dzenBGColor = "#ffffff" 
--   ,MyBars.dzenFGColor = "#ffffff" 
--} 

bar = dzenXMonadBar -- { MyBars.dzenBGCOlor = "#ffffff" } 

main = do
--    nScreens <- countScreens    
    dzenLeftTopBar <- spawnPipe bar
    xmonad $ withUrgencyHookC LibNotifyUrgencyHook myUrgencyHookConfig
           $ defaultConfig {
                             modMask               = mod4Mask
                            -- key bindings
                            ,keys                  = myKeys
                            ,mouseBindings         = myMouseBindings
                            -- ws setup
--                            ,workspaces            = withScreens nScreens myWorkspaces
                            ,workspaces            = myWorkspaces

                            -- predefined windows behavior
                            ,manageHook            = myManageHook <+> namedScratchpadManageHook myScratchpads
                            -- state switch trigger with bar
                            ,logHook               = myLogHook dzenLeftTopBar
                            ,layoutHook            = myLayout
                            -- blah blah
                            ,borderWidth           = 2 
                            ,normalBorderColor     = "#cccfff"
                            ,focusedBorderColor    = "#628600"
                           } 
