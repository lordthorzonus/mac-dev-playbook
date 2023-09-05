#!/bin/sh

############## PRIMARY DISPLAY SPACES ##############
SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
SPACE_CLICK_SCRIPT="yabai -m space --focus \$SID 2>/dev/null"

for i in "${!SPACE_ICONS[@]}"; do
    sid=$(($i + 1))
    sketchybar --add space space.$sid left \
        --set space.$sid associated_space=$sid \
        icon=${SPACE_ICONS[i]} \
        icon.color=$OVERLAY1 \
        icon.padding_right=5 \
        icon.highlight_color=$WHITE \
        background.padding_right=0 \
        background.padding_right=0 \
        background.height=25 \
        background.corner_radius=0 \
        background.color=$BG \
        background.drawing=on \
        label.drawing=off \
        click_script="$SPACE_CLICK_SCRIPT"
done
