import XMonad
import XMonad.Util.Run -- spawnPipe
import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedScratchpad

import MyKeyBindings
import MyHooks -- myManageHook, myLogHook, myUrgencyHookC
import MyWorkspaces
import MyLayout
import MyBars -- bars and popup bars
import MyScratchpads

import XMonad.Hooks.FadeInactive

myBlinkUrgencyHook :: SpawnUrgencyHook
myBlinkUrgencyHook = SpawnUrgencyHook "~/.xmonad/scripts/blink.sh "

bar = dzenXMonadBar -- { MyBars.dzenBGCOlor = "#ffffff" } 
-- tray = trayerXMonadTray

main = do
    dzenLeftTopBar <- spawnPipe bar
    trayRightTop   <- spawnPipe tray
    xmonad 
           $ withUrgencyHookC LibNotifyUrgencyHook myUrgencyHookConfig
           $ withUrgencyHook myBlinkUrgencyHook
           $ defaultConfig {
                             modMask               = mod4Mask
                            ,terminal              = "urxvtc" -- no daemon, no terminal
                            -- key bindings
                            ,keys                  = myKeys
                            ,mouseBindings         = myMouseBindings
                            -- ws setup
                            ,workspaces            = myWorkspaces
                            -- predefined windows behavior
                            ,manageHook            = myManageHook <+> namedScratchpadManageHook myScratchpads
                            -- state switch trigger with bar
                            ,logHook               = myLogHook dzenLeftTopBar <+> myLogHook trayRightTop >> fadeInactiveCurrentWSLogHook 0.9
                            ,layoutHook            = myLayout
                            -- blah blah
                            ,borderWidth           = 1
                            ,normalBorderColor     = "#002b36"
                            ,focusedBorderColor    = "#628600"
                           } 
