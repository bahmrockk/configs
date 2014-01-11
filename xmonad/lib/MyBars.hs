module MyBars (DzenBar(..), dzenXMonadBar) where
import qualified Data.Map        as M
import Data.Maybe

data DzenBar = DzenBar {
    dzenBGColor:: !String
    ,dzenFGColor:: !String
    }
dzenXMonadBar::String

defaultColors = DzenBar {
   dzenBGColor = "#1B1D1E"
   ,dzenFGColor = "#646464"
 }   

dzenXMonadBar =  
   ("dzen2 -p " ++ dzenProperties)
   where
--   dzenBGColor = "#1B1D1E"
--   dzenFGColor = "#646464"
   dzenProperties = " -ta l" -- orientation title [l|c|r]
                  ++" -bg '" ++ dzenBGColor MyBars.defaultColors ++ "'"
                  ++" -fg '" ++ dzenFGColor MyBars.defaultColors ++ "'"
                  ++" -sa c" -- orientation slave if applicable
                  ++" -y 0"  -- y offset
                  ++" -h 24" -- height
                  ++" -xs 1" -- on monitor X <- defaultColors
