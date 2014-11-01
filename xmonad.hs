-- Core
import XMonad
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import System.Exit
import Graphics.X11.Xlib
import Graphics.X11.ExtraTypes.XF86
--import IO (Handle, hPutStrLn)
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
import Data.Ratio ((%))
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.Spacing
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Gaps
import XMonad.Hooks.EwmhDesktops

defaults = defaultConfig {
        terminal      = "terminator"
        --, font		  = "xft:DejaVu Sans:size=10"
        , workspaces  = myWorkspaces
        --, defaultGaps  = myDefaultGaps
        , modMask     = mod4Mask
        , borderWidth = 1
        , layoutHook  = myLayoutHook
        , manageHook  = myManageHook 
	}`additionalKeys` myKeys

myDefaultGaps   = [(0,15,0,0)]
myWorkspaces :: [String]
myWorkspaces =  ["web","dev","term","VMs","0","1","2"]

myTabConfig = defaultTheme {
   activeColor         = "#6666cc"
  , activeBorderColor   = "#000000"
  , inactiveColor       = "#666666"
  , inactiveBorderColor = "#000000"
  , decoHeight          = 10
 }
myLayoutHook         = gaps [(U,15)] $ toggleLayouts (noBorders Full) $
                              smartBorders  $ Mirror tiled ||| Grid ||| tabbed shrinkText myTabConfig
                              where tiled = Tall 1 0.03 0.68
                              
myManageHook :: ManageHook
myManageHook2 = composeAll $ [ 
	className =? "gedit" 			--> doF (W.shift "b")
	, className =? "VirtualBox"		--> doShift "VMs"
	, className =? "Terminator"		--> doShift "term"
	, className =? "Opera" 			--> doF (W.shift "a")
	, className =? "Mozilla Firefox" 	--> doF (W.shift "a")
	, className =? "Eclipse" 		--> doF (W.shift "b")
	, className =? "sublime-text-2" --> doF (W.shift "b")
	]

	
myManageHook = composeAll . concat $
	[ [className =? c --> doF (W.shift "web")		| c <- myWeb]
	, [className =? c --> doF (W.shift "dev")		| c <- myDev]
	, [className =? c --> doF (W.shift "term")		| c <- myTerm]
	, [className =? c --> doF (W.shift "VMs")		| c <- myVMs]
	, [manageDocks ]
	]
	where
	myWeb = ["Firefox","Chromium","Chrome"]
	myDev = ["Eclipse","Gedit","sublime-text-2"]
	myTerm = ["Terminator","xterm"]
	myVMs = ["VirtualBox"]
	
myKeys = [
         ((mod4Mask .|. controlMask, xK_Right), nextScreen) 
         , ((mod4Mask .|. controlMask, xK_Left ), prevScreen)
         , ((mod4Mask, xK_g), goToSelected defaultGSConfig)
	 , ((mod4Mask, xK_s), spawnSelected defaultGSConfig ["xterm","gmplayer","gvim"])
         ]
                   


main = do
	xmproc <- spawnPipe "/usr/bin/xmobar ~/.xmobarrc"
	xmonad $ defaults

