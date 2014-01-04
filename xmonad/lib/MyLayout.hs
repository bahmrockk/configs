module MyLayout where

import XMonad.Hooks.ManageDocks -- avoidStruts
import XMonad.Layout.NoBorders (smartBorders, noBorders)
import XMonad.Layout.PerWorkspace (onWorkspace, onWorkspaces)
import XMonad.Layout.IM
import XMonad.Layout.Circle
import XMonad.Layout.Tabbed
import XMonad.Layout.IM
import XMonad.Layout.SimpleFloat
--import XMonad.Layout.Spacing
--import XMonad.Layout.ResizableTile
--import XMonad.Layout.LayoutHints
--import XMonad.Layout.LayoutModifier
import XMonad.Layout.Grid
import XMonad.Layout
import Data.Ratio ((%))


myLayout = onWorkspace "Chat" imLayout $
           defaultLayout


defaultLayout = smartBorders
              $ avoidStruts 
              $ tiled ||| Circle ||| simpleFloat ||| Full ||| simpleTabbed ||| Grid
                where
                    tiled = Tall nmaster delta ratio
                    nmaster = 1
                    ratio = 3/5
                    delta = 3/100 

imLayout = avoidStruts $ withIM (1/4) (Role "buddy_list") (Grid ||| Circle ||| simpleTabbed)

