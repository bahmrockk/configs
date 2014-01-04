module MyKeyBindings where

import XMonad
import XMonad.Prompt
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Prompt.Window
import XMonad.Actions.CycleWS
import XMonad.Actions.GridSelect
import XMonad.Actions.SpawnOn
import XMonad.Hooks.UrgencyHook
import XMonad.Util.NamedScratchpad
import XMonad.Layout.Monitor
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

import System.Exit
import MyScratchpads
--myKeys :: M.Map -> M.Map

myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    [   -- Restart xmonad
          ((modMask .|. shiftMask .|. controlMask , xK_q), broadcastMessage ReleaseResources >> restart "xmonad" True)
        , ((modMask .|. shiftMask .|. controlMask , xK_BackSpace),io (exitWith ExitSuccess))
        --menu/tab mode
        , ((modMask                 ,xK_Tab      ), goToSelected myGSConfig)        
        -- shell/window prompts
        , ((modMask                 ,xK_Return   ), spawnHere $ XMonad.terminal conf)
        , ((modMask .|. shiftMask   ,xK_Return   ), spawnHere $ "firefox")
        , ((modMask .|. shiftMask   ,xK_z        ), spawn $ "/home/bahmrockk/.xmonad/showKeys.dzen")
        , ((modMask                 ,xK_a        ), spawn "xclock")
        , ((modMask                 ,xK_space    ), runOrRaisePrompt mySP)
        , ((modMask .|. shiftMask   ,xK_space    ), shellPrompt mySP)
        , ((modMask .|. controlMask ,xK_space    ), windowPromptGoto mySP)
        -- close focused window
        , ((modMask .|. shiftMask   ,xK_c        ), kill)
        -- swap the focused window and the master window
        , ((modMask                 ,xK_semicolon), windows W.swapMaster)
     -- cycle through workspaces
        , ((modMask                 ,xK_Right    ), moveTo Next (WSIs (return $ not . (=="SP") . W.tag)))
        , ((modMask                 ,xK_Left     ), moveTo Prev (WSIs (return $ not . (=="SP") . W.tag)))

        -- move windows through workspaces
        , ((modMask .|. shiftMask   ,xK_Right    ), shiftTo Next (WSIs (return $ not . (=="SP") . W.tag)))
        , ((modMask .|. shiftMask   ,xK_Left     ), shiftTo Prev (WSIs (return $ not . (=="SP") . W.tag)))
        , ((modMask .|. controlMask ,xK_Right    ), shiftTo Next EmptyWS)
        , ((modMask .|. controlMask ,xK_Left     ), shiftTo Prev EmptyWS)

        -- Rotate through layouts
        , ((modMask                 ,xK_grave    ), sendMessage NextLayout)
        , ((modMask .|. shiftMask   ,xK_grave    ), setLayout $ XMonad.layoutHook conf)
        -- Move focus to the next/previous window
        , ((modMask                 ,xK_j        ), windows W.focusDown)
        , ((mod1Mask                ,xK_Tab      ), windows W.focusDown)
        , ((modMask                 ,xK_k        ), windows W.focusUp)
        , ((mod1Mask .|. shiftMask  ,xK_Tab      ), windows W.focusUp)

        -- Swap the focused window with next/prev window
        , ((modMask .|. shiftMask   ,xK_j        ), windows W.swapDown)
        , ((modMask .|. shiftMask   ,xK_k        ), windows W.swapUp)
        , ((modMask                 ,xK_u        ), broadcastMessage ToggleMonitor >> refresh)
        , ((modMask                 ,xK_u        ), focusUrgent) 
        , ((modMask                 ,xK_BackSpace), toggleWS) 
        , ((modMask                 ,xK_y        ), toggleWS)
        -- Scratchpads
        , ((modMask .|. controlMask .|. shiftMask, xK_t), namedScratchpadAction myScratchpads "htop")
        , ((modMask .|. controlMask .|. shiftMask, xK_s), namedScratchpadAction myScratchpads "stardict")
        , ((modMask .|. controlMask .|. shiftMask, xK_n), namedScratchpadAction myScratchpads "notes")

   ]
    ++ -- switch between workspaces
    [((m .|. modMask, k), windows $ f i) 
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]
    ++ -- switch between physical screens
    [((m .|. modMask, k), screenWorkspace sc >>= flip whenJust (windows . f))
        | (k, sc) <- zip [xK_F1, xK_F2, xK_F3] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

-- shell prompt theme
mySP = defaultXPConfig
    { bgColor           = "black"
    , fgColor           = "white"
    , bgHLight          = "gray"
    , fgHLight          = "black"
    , borderColor       = "orange"
    , promptBorderWidth = 1
    , position          = Bottom
    , height            = 20
    , historySize       = 1000 }

myGSConfig = defaultGSConfig { 
                                gs_cellheight = 42
                              , gs_cellwidth = 120 
                             
                             }

