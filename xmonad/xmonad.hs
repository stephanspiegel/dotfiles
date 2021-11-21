import XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Ungrab
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import qualified XMonad.Util.Hacks as Hacks
import XMonad.Hooks.ManageHelpers            -- provides isDialog

main :: IO ()
main = xmonad
     . Hacks.javaHack
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask = myModMask  -- Rebind Mod to the Super key
    , startupHook = myStartupHook
    , manageHook = myManageHook
    , terminal = "kitty"
    , normalBorderColor = "#3b4252"
    , focusedBorderColor = "#bc96da"
    }
  `additionalKeys`
    [ ((myModMask, xK_p), spawn "rofi -show run")
    , ((myModMask, xK_q), myReloadCmd)
    -- volume keys
    , ((0, 0x1008FF11), spawn "amixer -q sset Master 2%-")
    , ((0, 0x1008FF13), spawn "amixer -q sset Master 2%+")
    , ((0, 0x1008FF12), spawn "amixer set Master toggle") 
    ]

myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = "<fn=1><fc=#552c34,#1e222a:0>\xe0ba </fc></fn>" -- Separator character
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = xmobarColor "#A1BF8F" "" . wrap "·" "·"
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, _, _, wins] -> [ws, wins]
    , ppExtras          = [winTitles]
    }
  where
    formatFocused = wrap (section1 "\xf44a") (section1 "\xf438") . section2 . ppWindow 60
    formatUnfocused = wrap (section1 "·") (section1 "·") . section1 . ppWindow 30
    winTitles =  xmobarColorL "#1e222a" "#552c34" $ logTitles formatFocused formatUnfocused

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: Int -> String -> String
    ppWindow  l = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten' "…" l

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    separation1 = xmobarColor "#1e222a" "#552c34"
    separation2 = xmobarColor "#552c34" "#1e222a"
    section1 = xmobarColor "#e06c75" "#552c34"
    section2 = xmobarColor "#A1BF8F" "#552c34" 
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

myStartupHook = do
    spawnOnce "unclutter --timeout 2 --fork --ignore-scrolling"

myManageHook = composeAll
   [ className =? "KeePassXC" --> doShift "3"
   , className =? "Gimp"      --> doFloat
   , isDialog                 --> doCenterFloat
   ]

myModMask = mod4Mask

myReloadCmd = spawn "xmonad --recompile; killall xmobar; xmonad --restart"
