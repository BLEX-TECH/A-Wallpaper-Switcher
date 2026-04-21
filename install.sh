#!/bin/bash

# BlexTech Wallpaper Manager Installer
REPO_DIR=$(pwd)
TARGET_DIR="$HOME/.config/hypr/UserScripts"
WALL_DIR="$HOME/Pictures/Wallpapers"
SCRIPT_FILE="$TARGET_DIR/WallpaperManager.sh"

echo "BlexTech Wallpaper Manager: Starting Installation..."

# 1. Shell Detection
if command -v zsh >/dev/null 2>&1; then
    USER_SHELL=$(command -v zsh)
    echo "✔ Zsh detected."
else
    USER_SHELL=$(command -v bash)
    echo "✔ Bash detected."
fi

# 2. Folder Creation
mkdir -p "$TARGET_DIR"
mkdir -p "$WALL_DIR"

# 3. Script Installation (with dynamic shebang)
if [ -f "$REPO_DIR/WallpaperManager.sh" ]; then
    # Sets the first line to the user's detected shell
    sed "1s|.*|#!$USER_SHELL|" "$REPO_DIR/WallpaperManager.sh" > "$SCRIPT_FILE"
    chmod +x "$SCRIPT_FILE"
    echo "✔ Script installed to $TARGET_DIR"
else
    echo "✘ Error: WallpaperManager.sh not found in current directory!"
    exit 1
fi

# 4. Copying Wallpapers Folder Content
if [ -d "$REPO_DIR/Wallpapers" ]; then
    echo "Syncing BlexTech Wallpapers to $WALL_DIR..."
    # -v shows progress, -n prevents overwriting files they already have
    cp -vn "$REPO_DIR/Wallpapers/"* "$WALL_DIR/"
    echo "✔ Wallpaper folder synced successfully."
else
    echo "⚠ Warning: 'Wallpapers' folder not found in the repo. Skipping image copy."
fi

echo "---"
echo "Installation complete by BlexTech!"
echo "Your wallpapers are ready in $WALL_DIR"
