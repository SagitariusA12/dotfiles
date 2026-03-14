#!/usr/bin/env bash
mkdir -p ~/Pictures/screenshots
FILE=~/Pictures/screenshots/$(date +%Y%m%d_%H%M%S).png

case "$1" in
    area)   grimblast --freeze copysave area   "$FILE" ;;
    screen) grimblast copysave screen "$FILE" ;;
    active) grimblast copysave active "$FILE" ;;
esac

notify-send "Screenshot" "Salvo em $FILE" \
    --icon="$FILE" \
    --hint=string:image-path:"$FILE" \
    --expire-time=3000
