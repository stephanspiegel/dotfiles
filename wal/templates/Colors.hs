--Place this file in your .xmonad/lib directory and import module Colors into .xmonad/xmonad.hs config
--The easy way is to create a soft link from this file to the file in .xmonad/lib using ln -s
--Then recompile and restart xmonad.

module Colors
    ( wallpaper
    , background, foreground, cursor
    , color0, color1, color2, color3, color4, color5, color6, color7
    , color8, color9, color10, color11, color12, color13, color14, color15
    , lowerLeftTriangle, lowerRightTriangle, upperLeftTriangle, upperRightTriangle
    , batteryCharging
    , batteryCharged
    , batteryFull
    , batteryHalf
    , batteryEmpty
    , clock
    , volumeOn, volumeOff
    , xmobarColor, xmobarFont, icon
    , section1, section2, section3
    ) where

-- Shell variables
-- Generated by 'wal'
wallpaper="{wallpaper}"

-- Special
background="{background}"
foreground="{foreground}"
cursor="{cursor}"

-- Colors
color0="{color0}"
color1="{color1}"
color2="{color2}"
color3="{color3}"
color4="{color4}"
color5="{color5}"
color6="{color6}"
color7="{color7}"
color8="{color8}"
color9="{color9}"
color10="{color10}"
color11="{color11}"
color12="{color12}"
color13="{color13}"
color14="{color14}"
color15="{color15}"

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

startSection1 = concat ["<fn=1>", xmobarColor background color5 lowerLeftTriangle,"</fn>"]
startSection2 = concat ["<fn=1>", xmobarColor background color5 upperRightTriangle,"</fn>"]
startSection3 = concat ["<fn=1>", xmobarColor background color5 upperLeftTriangle,"</fn>"]
endSection3 = concat ["<fn=1>", xmobarColor background color5 lowerRightTriangle,"</fn>"]

section1 t = concat [ startSection1, xmobarColor background color5 t]
section2 t = concat [ startSection2, xmobarColor color5 background t]
section3 "" = ""
section3 t = concat [ startSection3, xmobarColor background color5 t, endSection3]
