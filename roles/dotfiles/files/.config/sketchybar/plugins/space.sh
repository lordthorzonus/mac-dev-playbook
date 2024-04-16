#!/bin/sh

############## PRIMARY DISPLAY SPACES ##############
SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --empty no --monitor all); do
    sketchybar --add item space.$sid left \
        --subscribe space.$sid aerospace_workspace_change \
        --set space.$sid \
        background.color=0x44ffffff \
        background.padding_right=0 \
        background.padding_right=0 \
        background.height=25 \
        background.corner_radius=0 \
        background.color=$BG \
        label="$sid" \
        click_script="aerospace workspace $sid" \
        script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
