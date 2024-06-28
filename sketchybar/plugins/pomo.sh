#!/usr/bin/env sh
source "$CONFIG_DIR/colors.sh" # Loads all defined colors
pomostatus=$(/usr/local/bin/pomo clock | tr -d " ")
case $pomostatus in
  W* ) 
    sketchybar --set $NAME icon.color=$BAR_COLOR         \
                      label.color=$BAR_COLOR       \
                      background.color=$FG_COLOR
;;
* )
  sketchybar --set $NAME icon.color=$FG_COLOR            \
                      label.color=$FG_COLOR        \
                      background.color=$BAR_COLOR
;;
esac
sketchybar --set $NAME icon="󰄉" label="$pomostatus"
