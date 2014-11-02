-- Core
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import Graphics.X11.ExtraTypes.XF86
--import IO (Handle, hPutStrLn)
import qualified System.IO.UTF8
import XMonad.Actions.CycleWS (nextScreen,prevScreen)
import Data.List
 
-- Prompts
import XMonad.Prompt
import XMonad.Prompt.Shell
 
-- Actions
import XMonad.Actions.MouseGestures
import XMonad.Actions.UpdatePointer
import XMonad.Actions.GridSelect
 
-- Utils
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Loggers
import XMonad.Util.EZConfig
-- Hooks
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.Place

-- Layouts
import XMonad.Layout.IndependentScreens
import XMonad.Layout.NoBorders
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.DragPane
import XMonad.Layout.LayoutCombinators hiding ((|||))
import XMonad.Layout.DecorationMadness
import XMonad.Layout.TabBarDecoration
import XMonad.Layout.IM
import XMonad.Layout.Grid
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.DwmStyle
import XMonad.Layout.Spiral

import Data.Ratio ((%))
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Gaps
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName

defaults = defaultConfig {
        terminal      = "terminator"
        --, font		  = "xft:DejaVu Sans:size=10"
        , workspaces  = myWorkspaces
        --, defaultGaps  = myDefaultGaps
        , modMask     = mod4Mask
        , borderWidth = 2
        , startupHook = setWMName "LG3D"
        , layoutHook  = myLayoutHook
        , manageHook  = myManageHook 
        , handleEventHook  = fullscreenEventHook
	}`additionalKeys` myKeys

myDefaultGaps   = [(0,15,0,0)]
myWorkspaces :: [String]
--myWorkspaces =  ["web","dev","term","VMs","0","1","2"]
myWorkspaces =  ["1:web","2:dev","3:term","4:vm","5:media"] ++ map show [6..9]

myTabConfig = defaultTheme {
   activeColor         = "#6666cc"
  , activeBorderColor   = "#000000"
  , inactiveColor       = "#666666"
  , inactiveBorderColor = "#000000"
  , decoHeight          = 10
 }

-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "green"

myLayoutHook         = spacing 6 $ gaps [(U,15)] $ toggleLayouts (noBorders Full) $
                              smartBorders  $ Mirror tiled ||| Grid ||| tabbed shrinkText myTabConfig
                              where tiled = Tall 1 0.03 0.68
                              
myManageHook :: ManageHook
	
myManageHook = composeAll . concat $
	[ [className =? c --> doF (W.shift "1:web")		| c <- myWeb]
	, [className =? c --> doF (W.shift "2:dev")		| c <- myDev]
	, [className =? c --> doF (W.shift "3:term")	| c <- myTerm]
	, [className =? c --> doF (W.shift "4:vm")		| c <- myVMs]
	, [manageDocks ]
	]
	where
	myWeb = ["Firefox","Chromium","Chrome"]
	myDev = ["Eclipse","Gedit","sublime_text","sublime-text"]
	myTerm = ["Terminator","xterm"]
	myVMs = ["VirtualBox"]
	
	--KP_Add KP_Subtract
myKeys = [
         ((mod4Mask .|. controlMask, xK_Right), nextScreen) 
         , ((mod4Mask .|. controlMask, xK_Left ), prevScreen)
         , ((mod4Mask, xK_g), goToSelected defaultGSConfig)
	 	 , ((mod4Mask, xK_s), spawnSelected defaultGSConfig ["xterm","gmplayer","gvim"])
	 	 , ((mod4Mask, xK_KP_Add), spawn "amixer set Master 10%+ && ~/.xmonad/getvolume.sh >> /tmp/.volume-pipe")
	 	 , ((mod4Mask, xK_KP_Subtract), spawn "amixer set Master 10%- && ~/.xmonad/getvolume.sh >> /tmp/.volume-pipe")
         ]
                   


main = do
	xmproc <- spawnPipe "/usr/bin/xmobar /home/tolkv/.xmonad/xmobar.hs"
	xmonad $ defaults {
	logHook =  dynamicLogWithPP $ defaultPP {
            ppOutput = System.IO.UTF8.hPutStrLn xmproc
          , ppTitle = xmobarColor xmobarTitleColor "" . shorten 100
          , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
          , ppSep = "   "
          , ppWsSep = " "
          , ppLayout = const ""
          , ppHiddenNoWindows = showNamedWorkspaces
      } 
} where showNamedWorkspaces wsId = if any (`elem` wsId) ['a'..'z']
                                       then pad wsId
                                       else ""

