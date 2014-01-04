import XMonad

import XMonad.Hooks.ManageDocks -- avoidStruts // Layout

--import System.IO
--import System.Exit

import XMonad.Util.Run -- spawnPipe

import XMonad.Actions.CycleWS
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

-- WS management
import XMonad.Actions.CycleWS

import Graphics.X11.Xinerama

import MyKeyBindings
import MyHooks 

import XMonad.Layout.Monitor
screenWidth :: Int -> IO Double
screenWidth s = do
    dsp <- openDisplay ""
    mss <- xineramaQueryScreens dsp
    return $ case mss of
        Nothing -> 0
        Just [] -> 0
        Just ss -> if s >= 0 && s < length ss -- prevent bad index
            then fromIntegral . xsi_width $ ss !! s else 0


myXmonadBar = "dzen2 -xs '1' -x '0' -y '0' -h '24' -w '1024' -ta 'l' -fg '#FFFFFF' -bg '#1B1D1E'"
myInfoTopBar = "i3status |dzen2 -xs 1 -x '1024' -y '0' -h '24' -w '1920' -ta 'r' -fg '#FFFFFF' -bg '#1B1D1E' -fn '-misc-fixed-medium-r-normal--13-120-75-75-C-70-iso8859-1'" 

main = do
--  myStatusBarPipe = spawnPipe myStatusBar
    dzenLeftBar <- spawnPipe myXmonadBar
    infoTopBar <- spawnPipe myInfoTopBar
--    xmonad $ myConfig
--myConfig = defaultConfig    { 
    xmonad $ withUrgencyHookC myUrgencyHook myUrgencyConfig $ withUrgencyHook myUrgencyHook2 $ defaultConfig {
                              modMask               = mod4Mask
                            , borderWidth           = 2 
                            , normalBorderColor     = "#cccfff"
                            , focusedBorderColor    = "#628600"
                            , keys                  = myKeys
                            , workspaces            = myWorkspaces
                            , layoutHook            = myLayout
                            , manageHook            = myManageHook <+> manageMonitor clock
                            , logHook               = myLogHook dzenLeftBar 
--                            , withUrgencyHook       = myUrgencyHook
                            , startupHook           = return ()
                            }
myWorkspaces :: [WorkspaceId]
myWorkspaces = ["Main", "Web", "Consoles", "Chat", "Mail", "Media" ] ++ map show [7..9 :: Int]

myLayout = ModifiedLayout clock $ smartBorders 
          $ onWorkspace "Chat" imLayout
          $ avoidStruts 
          $ standardLayouts 
            where
                tiled = Tall nmaster delta ratio
                tiledNoMaster = Tall 0 delta ratio
                nmaster = 1
                ratio = 3/5
                delta = 3/100 
                standardLayouts = tiled ||| spiral (1 % 1) ||| Circle ||| Full ||| simpleTabbed ||| Grid
                imLayout = withIM (5/23) (Role "buddy_list") (Grid ||| Circle ||| simpleTabbed)

clock = monitor {
      -- Cairo-clock creates 2 windows with the same classname, thus also using title
      prop = ClassName "Cairo-clock" `And` Title "MacSlow's Cairo-Clock"
      -- rectangle 150x150 in lower right corner, assuming 1280x800 resolution
    , rect = Rectangle (1280-150) (800-150) 150 150
      -- avoid flickering
    , persistent = True
      -- make the window transparent
    , opacity = 0.6
      -- hide on start
    , visible = False
      -- assign it a name to be able to toggle it independently of others
    , name = "clock"
    }
