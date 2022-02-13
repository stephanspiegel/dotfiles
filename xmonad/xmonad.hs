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
import Colors hiding (xmobarColor)

main :: IO ()
main = xmonad
     . Hacks.javaHack
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp myBarCommand (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig

myConfig = def
    { modMask = myModMask  -- Rebind Mod to the Super key
    , startupHook = myStartupHook
    , manageHook = myManageHook
    , terminal = "kitty"
    , normalBorderColor = color1
    , focusedBorderColor = color2
    }
  `additionalKeys`
    [ ((myModMask, xK_p), spawn "rofi -show run")
    , ((myModMask, xK_q), myReloadCmd)
    -- volume keys
    , ((0, 0x1008FF11), spawn "amixer -q sset Master 2%-")
    , ((0, 0x1008FF13), spawn "amixer -q sset Master 2%+")
    , ((0, 0x1008FF12), spawn "amixer set Master toggle") 
    ]

myBarCommand = "xmobar ~/.config/xmobar/xmobar.hs"

myXmobarPP :: PP
myXmobarPP = def
    { ppTitleSanitize   = xmobarStrip
    , ppSep             = ""
    , ppCurrent         = xmobarColor "#A1BF8F" "" . wrap "·" "·"
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, _, _, wins] -> [ws, wins]
    , ppExtras          = [winTitles]
    }
  where
    formatFocused = wrap (xmobarColor color2 color5 "\xf44a") (xmobarColor color2 color5 "\xf438") . ppWindow 60
    formatUnfocused = wrap "·" "·" . ppWindow 30
    winTitles =  section3L $ logTitles formatFocused formatUnfocused
    section3L = onLogger section3

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: Int -> String -> String
    ppWindow l = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten' "…" l

    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""

myStartupHook = do
    spawnOnce "unclutter --timeout 2 --fork --ignore-scrolling"

myManageHook = composeAll
   [ className =? "KeePassXC"        --> doShift "3"
   , className =? "MultiMC5"         --> doShift "6"
   , className =? "Minecraft 1.12.2" --> doShift "6"
   , className =? "Gimp"             --> doFloat
   , isDialog                        --> doCenterFloat
   ]

myModMask = mod4Mask

myReloadCmd = spawn "xmonad --recompile; killall xmobar; xmonad --restart"
