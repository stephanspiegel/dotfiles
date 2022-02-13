import Xmobar
import Data.List
import Colors

config :: Config
config = defaultConfig 
    { font = "xft:JetBrainsMono Nerd Font:weight=bold:pixelsize=16:antialias=true:hinting=true"
    , additionalFonts = [ "xft:JetBrainsMono Nerd Font:size=21" ]
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
                , "--low", colorString color5 color1
                -- , "--normal", colorString 
                , "--high", colorString color2 color1
                , "--" 
                , "-o", "<left>"  -- discharging status
                , "-O", xmobarColor color2 color1 (batteryCharging ++ "<left>") -- AC "on" status
                , "-i" , xmobarColor color2 color1 batteryCharged -- charged status
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
                , "--offc", color3 
                , "--off", volumeOff
                , "--onc", color2
                ]
        , Run $ Com "/home/stephan/.config/xmobar/scripts/wifi.sh" [] "wifi" 30
        ]
}

-- Colors
{- foreground = "#1E222A"
background = "#ff6c6b"
color1 = "#552c34"
color2 = "#A1BF8F"
color3 = "#CD8A49"
color4 = "#e06c75" 
color5 = "#AB3A24"  -}

-- Icons
lowerLeftTriangle  = "\xe0b8" ++ " " -- 
lowerRightTriangle = "\xe0ba" ++ " " -- 
upperLeftTriangle  = "\xe0bc" ++ " " -- 
upperRightTriangle = "\xe0be" ++ " " -- 
batteryCharging    = icon "\xf587"   -- 
batteryCharged     = icon "\xf584"   -- 
batteryFull        = icon "\xf578"   -- 
batteryHalf        = icon "\xf57d"   -- 
batteryEmpty       = icon "\xf579"   -- 
clock              = icon "\xf017"   -- 
volumeOn           = icon "\xfa7d"   -- 墳
volumeOff          = icon "\xfa80"   -- 婢

startSection1 = concat ["<fn=1>", xmobarColor color2 color1 lowerLeftTriangle,"</fn>"]
startSection2 = concat ["<fn=1>", xmobarColor color2 color1 upperRightTriangle,"</fn>"]

section1 t = concat [ startSection1, xmobarColor background color1 t]
section2 t = concat [ startSection2, xmobarColor color1 background t]

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

-- Use xmobar escape codes to output a string with given foreground and background colors.
-- Source: https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/src/XMonad.Hooks.DynamicLog.html#xmobarColor
xmobarColor ::
  -- | foreground color: a color name, or #rrggbb format
  String ->
  -- | background color
  String ->
  -- | output string
  String ->
  String
xmobarColor fg bg = wrap open "</fc>"
  where
    open :: String
    open = concat ["<fc=", fg, if null bg then "" else "," <> bg, ">"]

-- Use xmobar escape codes to output a string with given font.
xmobarFont ::
    -- | Font number
    String ->
    -- | output string
    String ->
    String
xmobarFont fn = wrap open "</fn>"
  where
      open :: String
      open = "<fn=" ++ fn ++ ">"

icon :: String -> String
icon i = xmobarFont "1" $ i ++ " "

-- Wrap a string in delimiters, unless it is empty.
-- Source: https://hackage.haskell.org/package/xmonad-contrib-0.15/docs/src/XMonad.Hooks.DynamicLog.html#wrap
wrap ::
  -- | left delimiter
  String ->
  -- | right delimiter
  String ->
  -- | output string
  String ->
  String
wrap _ _ "" = ""
wrap l r m = l <> m <> r

main :: IO ()
main = xmobar config
