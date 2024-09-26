#!/usr/bin/env sh
source "$CONFIG_DIR/colors.sh" # Loads all defined colors
# pomostatus=$(/usr/local/bin/pomo clock | tr -d " ")
# case $pomostatus in
#   W* ) 
#     sketchybar --set $NAME icon.color=$BAR_COLOR         \
#                       label.color=$BAR_COLOR       \
#                       background.color=$FG_COLOR
# ;;
# * )
#   sketchybar --set $NAME icon.color=$FG_COLOR            \
#                       label.color=$FG_COLOR        \
#                       background.color=$BAR_COLOR
# ;;
# esac
pr_review_requests=$(gh search prs --review-requested=@me --state=open --json id --jq 'length')
if (( pr_review_requests > 0 )); then
  sketchybar --set $NAME icon.color=$BAR_COLOR        \
                    label.color=$BAR_COLOR            \
                    background.color=$FG_COLOR        \
                    background.border_color=$FG_COLOR
else
  sketchybar --set $NAME icon.color=$FG_COLOR         \
                   label.color=$FG_COLOR              \
                   background.color=$BAR_COLOR        \
                   background.border_color=$BAR_COLOR
fi
sketchybar --set $NAME background.padding_right=10
sketchybar --set $NAME icon="" label="$pr_review_requests"
