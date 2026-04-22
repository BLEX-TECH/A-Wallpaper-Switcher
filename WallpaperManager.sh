#!/bin/bash

# Everything is contained in this folder
BASE_DIR="$HOME/.config/Blex-Switcher"
DIR="$BASE_DIR/Wallpapers"
TEMP_LIST="/tmp/blex_wall_list.txt"

# Ensure the list is fresh
: > "$TEMP_LIST"

# Build the list using the absolute path to the .config folder
find "$DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | while read -r pic; do
    echo -en "$(basename "$pic")\0icon\x1f$pic\n" >> "$TEMP_LIST"
done

if [[ "$1" == "choose" ]]; then
    CHOICE=$(cat "$TEMP_LIST" | rofi -dmenu -i -p "󰸉 Blex Gallery" \
        -show-icons \
        -theme-str '
        window { width: 1000px; height: 750px; border-radius: 20px; background-color: #111111E0; border: 2px solid #ffffff10; }
        listview { columns: 4; lines: 3; spacing: 20px; padding: 30px; cycle: true; dynamic: true; }
        element { orientation: vertical; padding: 15px; border-radius: 15px; }
        element selected { background-color: #ffffff20; }
        element-icon { size: 160px; horizontal-align: 0.5; }
        element-text { horizontal-align: 0.5; }
        ')

    if [[ -n "$CHOICE" ]]; then
        SETTER=$(command -v swww || command -v awww)
        $SETTER img "$DIR/$CHOICE" --transition-type grow --transition-duration 1.2
    fi

elif [[ "$1" == "random" ]]; then
    PIC=$(find "$DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.webp" \) | shuf -n 1)
    [[ -n "$PIC" ]] && $(command -v swww || command -v awww) img "$PIC" --transition-type any
fi
