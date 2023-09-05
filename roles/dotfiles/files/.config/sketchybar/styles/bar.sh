#!/usr/bin/env bash

source ~/.config/sketchybar/styles/catpuccin-mocha.sh

# Bar config
sketchybar --bar \
    height=34 \
    corner_radius=0 \
    border_width=0 \
    margin=0 \
    blur_radius=50 \
    position=top \
    padding_left=10 \
    padding_right=10 \
    color=$BG \
    topmost=off \
    sticky=off \
    font_smoothing=off \
    y_offset=-2 \
    shadow=$CRUST

PADDINGS=5

# Setting up default values
defaults=(
    updates=when_shown
    icon.font="$FONT_ICON:Bold:14.0"
    icon.color=$ICON
    icon.padding_left=$PADDINGS
    icon.padding_right=$PADDINGS
    label.font="$FONT_ICON:Semibold:13.0"
    label.color=$TEXT
    label.padding_left=$PADDINGS
    label.padding_right=$PADDINGS
    padding_right=$PADDINGS
    padding_left=$PADDINGS
    background.height=30
    background.corner_radius=9
    popup.background.border_width=2
    popup.background.corner_radius=9
    popup.blur_radius=20
    popup.background.shadow.drawing=on
)

sketchybar --default "${defaults[@]}"
