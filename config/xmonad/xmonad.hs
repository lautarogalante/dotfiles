{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses, TypeSynonymInstances #-}
{-# OPTIONS_GHC -Wno-deprecations #-}

import qualified Codec.Binary.UTF8.String as UTF8
import Data.Monoid
import System.Exit
import XMonad
import qualified Data.Map as M
import Data.List
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.CycleWS
import XMonad.Layout.NoBorders
import XMonad.Hooks.ManageHelpers
import qualified XMonad.Layout.Fullscreen as FS
import XMonad.Util.Run(spawnPipe)
import XMonad.Actions.PhysicalScreens
import XMonad.Hooks.DynamicLog
import System.IO
import Control.Monad
import qualified XMonad.StackSet as W
import XMonad.Hooks.EwmhDesktops (ewmh, fullscreenEventHook)
import XMonad.Hooks.ManageDocks
import XMonad.Config.Desktop
import XMonad.Util.SpawnOnce

-- Make our own Picture-in-Picture mode
--import XMonad.Config.Prime (LayoutClass)
-- import Graphics.X11 (Rectangle(..))

--data PiP a = PiP deriving (Show, Read)

--mkpip rect@(Rectangle sx sy sw sh) (master:snd:ws) = [small, (master, rect)]
--  where small = (snd, (Rectangle px py pw ph))
--        px = sx + fromIntegral sw - fromIntegral pw - 32
--        py = sy + fromIntegral sh - fromIntegral ph - 32
--	pw = sw `div` 4
--	ph = sh `div` 4
--mkpip rect (master:ws) = [(master, rect)]
--mkpip rect [] = []

--instance LayoutClass PiP a where
 --   pureLayout PiP rect stack = mkpip rect ws
  --    where ws = W.integrate stack

   -- description _ = "PiP"
myTerminal :: String
myTerminal      = "alacritty"

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

myClickJustFocuses :: Bool
myClickJustFocuses = True


myModMask       = mod4Mask -- or mod4Mask for super
myWorkspaces    = ["web","a","b","c","long","mx","sfx"]

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [
      ((modm, xK_o), (spawn myTerminal))
    -- , ((modm, xK_q), (spawn "/usr/bin/bash -c 'notify-send -i time \"Right now, it is\" \"$(date \"+%-I:%M %p, %A %B %d, %Y\")\n$(acpi | sed \"s/Battery 0://\")\"'"))
    , ((modm.|. shiftMask,  xK_l), (spawn "slock"))
    , ((modm,     xK_j), windows W.focusDown)
    , ((modm,     xK_k), windows W.focusUp)
    , ((modm,     xK_space), sendMessage NextLayout)
    , ((mod4Mask, xK_p),              (spawn "dmenu_run"))
    , ((modm,     xK_c),              (spawn "xmonad --recompile && xmonad --restart"))
    , ((modm,     xK_z),              (spawn "setxkbmap -layout 'es,us'"))
     -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)
        -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)
    , ((modm .|. shiftMask,         xK_q), io (exitWith ExitSuccess))
    , ((modm,                       xK_q), kill)
    , ((modm,                       xK_t     ), withFocused $ windows . W.sink)
    , ((modm,                       xK_comma ), sendMessage (IncMasterN 1))
    , ((modm,                       xK_period), sendMessage (IncMasterN (-1)))
    , ((controlMask .|. myModMask,  xK_Right), nextWS)
    , ((controlMask .|. myModMask,  xK_Left), prevWS)
    , ((modm,                       xK_Left), onPrevNeighbour def W.view)
    , ((modm,                       xK_Right), onNextNeighbour def W.view)
    , ((modm .|. shiftMask,         xK_Left), onPrevNeighbour def W.shift)
    , ((modm .|. shiftMask,         xK_Right), onNextNeighbour def W.shift)
    , ((controlMask .|. myModMask .|. shiftMask, xK_Right), shiftToNext >> nextWS)
    , ((controlMask .|. myModMask .|. shiftMask, xK_Left), shiftToPrev >> prevWS)
    ] 

myLayout = tiled ||| (Mirror tiled) ||| Full -- ||| PiP
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = toRational (2 / (1 + sqrt 5 :: Double))

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ 
      className =? "mpv" --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , className =? "foobar"      --> doShift "sfx"
    , title =? "foobar"      --> doShift "sfx"
    , fmap (isInfixOf "display") appCommand --> doFloat
    , (stringProperty "WM_WINDOW_ROLE" =? "GtkFileChooserDialog") --> doFullFloat
    , isFullscreen                  --> doFullFloat
    , FS.fullscreenManageHook
    ]
    where
    appCommand = stringProperty "WM_COMMAND"
    --doShiftAndGo = doF . liftM2 (.) W.greedyView W.shift

myStartupHook = do
  spawnOnce "$HOME/.config/polybar/launch.sh"
  --spawnOnce "$HOME/Documentos/ScriptMaintenance/fondo.sh"
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
main = do
    xmonad $ desktopConfig {
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = 0,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        keys               = \c -> myKeys c `M.union` keys XMonad.def c,
        layoutHook         = desktopLayoutModifiers $ noBorders $ myLayout,
        manageHook         = myManageHook <+> manageHook desktopConfig,
        handleEventHook    = fullscreenEventHook <+> handleEventHook desktopConfig,
	      startupHook        = myStartupHook <+> startupHook desktopConfig
    }
