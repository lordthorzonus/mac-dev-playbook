source ~/.config/sketchybar/styles/catpuccin-mocha.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.color=$WHITE
else
    sketchybar --set $NAME label.color=$OVERLAY1
fi
