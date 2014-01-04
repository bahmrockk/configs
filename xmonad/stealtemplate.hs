-- This is the main configuration file
-- 
-- Most of this part is blatantly copied from http://haskell.org/haskellwiki/\
-- Xmonad/Config_archive/John_Goerzen's_Configuration

--import XMonad.Hooks.SetCursor
import System.Exit
import System.IO
import XMonad
import XMonad.Actions.CycleWS
import XMonad.Actions.DwmPromote
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.Script
import XMonad.Hooks.SetWMName
import XMonad.Layout.ShowWName
import XMonad.Util.NamedScratchpad
import XMonad.Util.Run(spawnPipe)
import qualified Data.Map as M
import qualified XMonad.StackSet as W

myWorkspaces = map show [1..4]                                                 -- Workspace names

scratchpads = [NS "quake" "mrxvt -name quake" findQuake manageQuake 
              ] 
    where
        findQuake = resource =? "quake"
        manageQuake = customFloating $ W.RationalRect l t w h
            where 
                h = 0.33      -- height, 33% 
                w = 1         -- width, 100% 
                t = 0         -- top edge
                l = 0         -- centered left/right

myScratchpad = namedScratchpadManageHook scratchpads

myManageHook = manageDocks <+> manageHook defaultConfig <+> myScratchpad 

myLayoutHook =  avoidStruts  $ showWName (layoutHook defaultConfig) 

main = xmonad =<< dzen myConfig 

myConfig =  defaultConfig
        { manageHook = myManageHook
        , layoutHook = myLayoutHook                                            -- Make way for system tray.
        , modMask = mod4Mask                                                   -- Make Super key as the main modifier. 
        , borderWidth = 2 
        , terminal = "mrxvt"
        , normalBorderColor = "#cccccc"
        , focusedBorderColor = "#cd8b00"    
        , workspaces = myWorkspaces
        , keys = \_ -> M.fromList  crystalKeys                                 -- Add list "crystalKeys" key bindings
        , startupHook =  myStartupHook
        }

myStartupHook = do
--    setDefaultCursor 68                                                        -- Presently seems not in the package of Debian 
    execScriptHook  "autostart"                                                -- Run  ~/.xmonad/hooks with arg autostart
    setWMName  "LG3D"                                                         -- For Java apps 

-- This is the list of custom key bindings
crystalKeys =
    [ ((mod4Mask .|. shiftMask, xK_l), spawn "xscreensaver-command -lock")     -- Lock the screen
    , ((mod4Mask,               xK_grave), namedScratchpadAction scratchpads "quake") 
    ]
    ++
    -- Workspace keys
    [ ((m .|. mod4Mask, k), windows $ f i)
        | (i, k) <- zip myWorkspaces [xK_F1..xK_F12]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]                  -- Move windows to workspaces
    ]   
    ++
    -- More workspace keys
    [ ((mod4Mask,               xK_Escape), toggleWS)                          -- Toggle viewed workspace
    , ((mod4Mask,               xK_Up), prevWS)                                -- Go to prev workspace
    , ((mod4Mask,               xK_Down), nextWS)                              -- Go to next workspace
    , ((mod4Mask,               xK_Left), prevScreen)                          -- Go to prev screen 
    , ((mod4Mask,               xK_Right), nextScreen)                         -- Go to next screen
    , ((mod4Mask .|. shiftMask, xK_Up), shiftToPrev >> prevWS)                 -- Move window to previous workspace
    , ((mod4Mask .|. shiftMask, xK_Left), shiftPrevScreen >> prevScreen)       -- Move window to previous workspace
    , ((mod4Mask .|. shiftMask, xK_Down), shiftToNext >> nextWS)               -- Move window to next workspace
    , ((mod4Mask .|. shiftMask, xK_Left), shiftNextScreen >> nextScreen)       -- Move window to previous workspace
    ]
    ++
    -- Pulse volume control keys
    [ ((mod4Mask,  xK_8), spawn "~/bin/pulse_vol.sh mute")                     -- Mute the pulseaudio volume
    , ((mod4Mask,  xK_9), spawn "~/bin/pulse_vol.sh decrease")                 -- Decrease the pulseaudio volume
    , ((mod4Mask,  xK_0), spawn "~/bin/pulse_vol.sh increase")                 -- Increase the pulseaudio volume
    ]
    ++
    --  Window settings
    [ ((mod4Mask .|. shiftMask, xK_BackSpace), kill)                           -- Kill the focused window
    , ((mod4Mask,               xK_Tab), goToSelected defaultGSConfig)
    ]
    ++
    -- Colemak specific changes
    [ ((mod4Mask .|. shiftMask, xK_grave), spawn "mrxvt")                      -- spawn terminal
    , ((mod4Mask .|. shiftMask, xK_space), sendMessage NextLayout)             -- next layout
    , ((mod4Mask .|. shiftMask, xK_r), refresh)                                -- resize to correct size
    , ((mod4Mask,               xK_n), windows W.focusDown)                    -- move focus; next window
    , ((mod4Mask,               xK_e), windows W.focusUp)                      -- move focus; prev. window
    , ((mod4Mask,               xK_m), windows W.focusMaster)                  -- focus on master
    , ((mod4Mask,               xK_Return), dwmpromote)                        -- swap focused with master/next
    , ((mod4Mask .|. shiftMask, xK_n), windows W.swapDown)                     -- swap focused with next window
    , ((mod4Mask .|. shiftMask, xK_e), windows W.swapUp)                       -- swap focused with prev. window
    , ((mod4Mask,               xK_h), sendMessage Shrink)                     -- shrink master area
    , ((mod4Mask,               xK_i), sendMessage Expand)                     -- expand master area
    , ((mod4Mask,               xK_t), withFocused $ windows . W.sink)         -- put window back on tiling layer
    , ((mod4Mask,               xK_comma), sendMessage (IncMasterN 1))         -- increase number of windows in master pane
    , ((mod4Mask,               xK_period), sendMessage (IncMasterN (-1)))     -- decrease number of windows in master pane
    , ((mod4Mask,               xK_b), sendMessage ToggleStruts)               -- toggle status bar gap, uses ManageDocks
    , ((mod4Mask .|. shiftMask, xK_q), io (exitWith ExitSuccess))              -- exit Xmonad
    , ((mod4Mask,               xK_q), broadcastMessage ReleaseResources
                                       >> restart "xmonad" True)               -- restart xmonad
    ]
