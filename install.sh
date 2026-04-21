#!/bin/bash

REPO_DIR=$(pwd)
TARGET_DIR="$HOME/.config/hypr/UserScripts"
WALL_DIR="$HOME/Pictures/Wallpapers"
SCRIPT_FILE="$TARGET_DIR/WallpaperManager.sh"

echo "BlexTech Wallpaper Manager Installer starting..."

# 1. Detect Shell
if command -v zsh >/dev/null 2>&1; then
    USER_SHELL=$(command -v zsh)
    echo "✔ Zsh detected."
elif command -v bash >/dev/null 2>&1; then
    USER_SHELL=$(command -v bash)
    echo "✔ Bash detected."
else
    echo "✘ Error: Neither bash nor zsh found. How are you even running this?"
    exit 1
fi

# 2. Setup Folders
mkdir -p "$TARGET_DIR"
mkdir -p "$WALL_DIR"

# 3. Install Script & Set Shebang
if [ -f "$REPO_DIR/WallpaperManager.sh" ]; then
    # This line replaces the first line of the script with the detected shell path
    sed "1s|.*|#!$USER_SHELL|" "$REPO_DIR/WallpaperManager.sh" > "$SCRIPT_FILE"
    chmod +x "$SCRIPT_FILE"
    echo "✔ Script installed with $USER_SHELL support."
else
    echo "✘ Error: WallpaperManager.sh missing!"
    exit 1
fi

# 4. Sync Wallpapers
if [ -d "$REPO_DIR/Wallpapers" ]; then
    echo "Syncing 50+ BlexTech wallpapers..."
    cp -rn "$REPO_DIR/Wallpapers/"* "$WALL_DIR/"
    echo "✔ Done."
fi

echo "Installation finished by BlexTech."
