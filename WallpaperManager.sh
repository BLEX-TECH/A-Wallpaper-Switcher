#!/bin/bash

# Path to wallpapers
DIR="$HOME/Pictures/Wallpapers"
TEMP_LIST="/tmp/wall_list.txt"

# Clear/Create temp file
: > "$TEMP_LIST"

# Build list - Compatible with both Bash and Zsh
# Handles spaces in filenames and multiple extensions
find "$DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | while read -r pic; do
    echo -en "$(basename "$pic")\0icon\x1f$pic\n" >> "$TEMP_LIST"
done

# Launch Rofi Gallery
CHOICE=$(cat "$TEMP_LIST" | rofi -dmenu -i -p "󰸉 Wallpapers" \
    -show-icons \
    -theme-str '
    window {
        width: 1000px;
        height: 700px;
        border-radius: 20px;
        background-color: #111111E0;
    }
    listview {
        columns: 4;
        lines: 3;
        spacing: 15px;
        padding: 20px;
        cycle: true;
        dynamic: true;
        layout: vertical;
    }
    element {
        orientation: vertical;
        padding: 10px;
        border-radius: 10px;
    }
    element selected {
        background-color: #ffffff20;
    }
    element-icon {
        size: 150px;
    }
    element-text {
        horizontal-align: 0.5;
    }
    ')

# Apply Selection
if [[ -n "$CHOICE" ]]; then
    SETTER=$(command -v swww || command -v awww)
    $SETTER img "$DIR/$CHOICE" --transition-type grow --transition-duration 1.2
fi
