import Xmobar
import Data.List
import Colors

config :: Config
config = defaultConfig 
    { font = "xft:JetBrainsMono Nerd Font:weight=bold:pixelsize=14:antialias=true:hinting=true"
    , additionalFonts = [ "xft:JetBrainsMono Nerd Font:size=19:antialias=true:hinting=true" ]
    , bgColor = background
    , fgColor = foreground
    , position = Top
    , border = FullB
    , borderColor = background
    , sepChar = "%"   -- delineator between plugin names and straight text
    , alignSep = "}{"  -- separator between left-right alignment
    , template = intercalate "" templateLines
    , lowerOnStart = True        -- send to bottom of window stack on start
    , hideOnStart = False        -- start with window unmapped (hidden)
    , allDesktops = True         -- show on all desktops
    , overrideRedirect = True    -- set the Override Redirect flag (Xlib)
    , pickBroadest = False       -- choose widest display (multi-monitor)
    , persistent = True          -- enable/disable hiding (True = disabled)
    , commands = 
        [ Run $ Com "/home/stephan/.config/xmobar/scripts/weather.sh" ["bar"] "weather" 36000
        , Run $ XMonadLog  -- workspace indicators
        , Run $ Battery      
                [ "--template" , "<acstatus>"
                , "--Low", "15"
                , "--High", "80"
                , "--low", colorString color1 color5 
                , "--normal", colorString background color5
                , "--high", colorString background color5
                , "--" 
                , "-o", "<left>"  -- discharging status
                , "-O", xmobarColor color1 color5 (batteryCharging ++ "<left>") -- AC "on" status
                , "-i" , xmobarColor color1 color5 batteryCharged -- charged status
                , "-P" -- show percent sign
                , "--highs", xmobarFont "1" batteryFull
                , "--mediums", xmobarFont "1" batteryHalf
                , "--lows", xmobarFont "1" batteryEmpty
                ] 
                50
        , Run $ Date (clock ++ "%FT%H:%M ") "date" 10
        , Run $ Alsa "default" "Master" 
                [ "--template", "<status><volume>%"
                , "--"
                , "--on", volumeOn
                , "--offc", colorString color5 background 
                , "--off", volumeOff
                , "--onc", colorString color5 background
                ]
        , Run $ Com "/home/stephan/.config/xmobar/scripts/wifi.sh" [] "wifi" 30
        ]
}

templateLines = 
    "%XMonadLog%}{" : thisOrThat section1 section2 sections

sections = 
    [ "%battery%"
    , "%weather%"
    , "%wifi%"
    , "%alsa:default:Master%"
    , "%date%"
    ]

-- Given two functions p and q and a list, apply p and q alternatively to the list
thisOrThat :: (a -> b) -> (a -> b) -> [a] -> [b]
thisOrThat p q [] = []
thisOrThat p q [x] = [p x]
thisOrThat p q (x : y : xs) = p x : q y : thisOrThat p q xs

colorString :: String -> String -> String
colorString fg bg = concat [fg, ",", bg, ":0"]

main :: IO ()
main = xmobar config
