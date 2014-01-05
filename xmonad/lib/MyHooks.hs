module MyHooks where

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.DynamicHooks
import System.IO
import XMonad.Hooks.ManageDocks

import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook

import XMonad.Util.Run
import XMonad.Util.NamedScratchpad
import XMonad.Core
import XMonad

import qualified XMonad.StackSet as W
import XMonad.Util.NamedWindows

import MyScratchpads

import XMonad.Actions.WorkspaceNames 

xmonadDir = "/home/bahmrockk/.xmonad/icons/"

data LibNotifyUrgencyHook = LibNotifyUrgencyHook deriving (Read, Show)

instance UrgencyHook LibNotifyUrgencyHook where
    urgencyHook LibNotifyUrgencyHook w = do
        name     <- getName w
        Just idx <- fmap (W.findTag w) $ gets windowset
        safeSpawn "notify-send" [show name, "workspace " ++ idx]

myUrgencyHookConfig = urgencyConfig { remindWhen=Every 60}

-- WM_WINDOW_ROLE(STRING) = "conversation" <-- set urgent on spawn

myManageHook :: ManageHook
myManageHook = (composeAll . concat $
    [[role         =? r --> doCenterFloat      |  r <- myFloatRoles    ]
--     [role         =? r --> :
    ,[resource     =? r --> doIgnore           |  r <- myIgnores       ]
    ,[className    =? c --> doShift "Main"     |  c <- myDev           ]
    ,[className    =? c --> doShift "Web"      |  c <- myWebs          ]
    ,[className    =? c --> doShift "Consoles" |  c <- myConsoles      ]
    ,[className    =? c --> doShift "Media"    |  c <- myMusic         ]
    ,[className    =? c --> doShift "Media"    |  c <- myMedia         ]
    ,[className    =? c --> doShift "Chat"     |  c <- myChat          ]
    ,[className    =? c --> doShift "Mail"     |  c <- myMail          ]
    ,[className    =? c --> doShift "7"        |  c <- myGimp          ]
    ,[className    =? c --> doCenterFloat      |  c <- myFloats        ]
    ,[name         =? n --> doCenterFloat      |  n <- myFloatNamed    ]
    ,[isFullscreen --> myDoFullFloat                                   ]  
    ]) <+> namedScratchpadManageHook myScratchpads 
    where
        role      = stringProperty "WM_WINDOW_ROLE"
        name      = stringProperty "WM_NAME"
 
        -- classnames
        myFloatRoles = ["gimp-toolbox"]
        myFloats  = ["Xmessage", "Downloads", "Popup"]
        myWebs      = [] --TODO: Find a way to spawn on other WS than the hooked one
        myMedia     = ["Plugin-container", "Google-chrome","Chromium", "Chromium-browser"]
        myMusic	    = ["Spotify"]
        myChat	    = ["Pidgin","Buddy List", "Skype"]
        myGimp	    = ["Gimp"]
        myDev	    = ["Eclipse"]
        myConsoles  = ["xterm"]
        myMail      = ["Mail", "Thunderbird"]
        -- resources
        myIgnores = []
 
        -- center Floats
        myFloatNamed = ["bashrun","Google Chrome Options","Chromium Options"]
 
        -- a trick for fullscreen but stil allow focusing of other WSs
        myDoFullFloat :: ManageHook
        myDoFullFloat = doF W.focusDown <+> doFullFloat



myLogHook :: Handle -> X ()
--myLogHook h = manageDocks <+> dynamicMasterHook <+> dynamicLogWithPP $ defaultPP 
myLogHook h = dynamicLogWithPP $ defaultPP
   {
          ppCurrent           = dzenColor "#4671D5" "#1B1D1E" . pad . wrap "[" "]"
        , ppVisible           = dzenColor "#1240AB" "#1B1D1E" . pad . wrap "[" "]"
        , ppHidden            = dzenColor "white" "#1B1D1E" . pad.wrap"(" ")"
        , ppHiddenNoWindows   = dzenColor "#7b7b7b" "#1B1D1E" 

        , ppUrgent            = dzenColor "#ff0000" "#AF1A1B" . pad . wrap "<<<" ">>>"
        , ppWsSep             = " "
        , ppSep = " | " 
        , ppLayout            = dzenColor "#ebac54" "#1B1D1E" .
        (\x -> case x of
         "Grid"          -> "^i(" ++ xmonadDir ++ "layouts/grid.xbm)"
         "Tall"          -> "^i(" ++ xmonadDir ++ "layouts/tall.xbm)"
         "Full"          -> "^i(" ++ xmonadDir ++ "layouts/full.xbm)"
         "Simple Float"  ->      "~"
         _               -> x
        )
        , ppTitle             = ("  " ++) . dzenColor "white" "#1B1D1E" . dzenEscape . shorten 70
        , ppSort              = fmap (namedScratchpadFilterOutWorkspace.) (ppSort defaultPP) 
        ,ppOutput             = hPutStrLn h
    }
    

