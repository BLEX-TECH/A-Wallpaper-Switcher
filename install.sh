#!/bin/bash

REPO_DIR=$(pwd)
INSTALL_PATH="$HOME/.config/Blex-Switcher"

echo "🚀 Installing Blex-Switcher to $INSTALL_PATH..."

# 1. Create the folder in .config
mkdir -p "$INSTALL_PATH/Wallpapers"

# 2. Move the script into .config/Blex-Switcher
if [ -f "$REPO_DIR/WallpaperManager.sh" ]; then
    cp "$REPO_DIR/WallpaperManager.sh" "$INSTALL_PATH/WallpaperManager.sh"
    chmod +x "$INSTALL_PATH/WallpaperManager.sh"
    echo "✔ Script moved to .config."
else
    echo "✘ Error: WallpaperManager.sh not found!"
    exit 1
fi

# 3. Move the Wallpapers folder into .config/Blex-Switcher/Wallpapers
if [ -d "$REPO_DIR/Wallpapers" ]; then
    echo "🖼  Copying 50+ Wallpapers to .config..."
    cp -rn "$REPO_DIR/Wallpapers/"* "$INSTALL_PATH/Wallpapers/"
    echo "✔ Wallpapers moved to .config."
fi

echo "---"
echo "✅ Installation Complete by BlexTech!"
echo "To use it, add this bind to your hyprland.conf:"
echo "bind = \$mainMod, W, exec, $INSTALL_PATH/WallpaperManager.sh choose"
