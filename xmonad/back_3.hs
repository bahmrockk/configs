import XMonad

import XMonad.Hooks.ManageDocks -- avoidStruts // Layout

--import System.IO
--import System.Exit

import XMonad.Util.Run -- spawnPipe

import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.EwmhDesktops

import XMonad.Layout.IM
import XMonad.Layout.Spiral
import XMonad.Layout.Circle
import XMonad.Layout.Tabbed
import XMonad.Layout.NoBorders (smartBorders, noBorders)
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.Reflect (reflectHoriz)
import XMonad.Layout.IM
import XMonad.Layout.SimpleFloat
import XMonad.Layout.Spacing
import XMonad.Layout.ResizableTile
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Grid

import Data.Ratio ((%))
-- data manipulation
import qualified Data.Map        as M
import qualified XMonad.StackSet as W
import XMonad.Util.NamedWindows
-- WS management
import XMonad.Actions.CycleWS

import Graphics.X11.Xinerama

import MyKeyBindings
import MyHooks 

import XMonad.Layout.Monitor
import Data.IORef

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["Main", "Web", "Consoles", "Chat", "Mail", "Media" ] ++ map show [7..9 :: Int]


main = do
    xmonad $ withUrgencyHook dzenUrgencyHook { args = ["-bg", "darkgreen", "-xs", "1"] }
           $ defaultConfig {
                             modMask               = mod4Mask
                            ,keys                  = myKeys
                            ,workspaces            = myWorkspaces
                            }

