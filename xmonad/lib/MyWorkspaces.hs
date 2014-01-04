module MyWorkspaces where

import XMonad.Core -- WorkspaceId

myWorkspaces :: [WorkspaceId]
myWorkspaces = ["Main", "Web", "Consoles", "Chat", "Mail", "Media" ] ++ map show [7..9 :: Int]


