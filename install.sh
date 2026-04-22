#!/bin/bash

# BlexTech Professional Installer
REPO_DIR=$(pwd)
INSTALL_PATH="$HOME/.config/Blex-Switcher"
SHORTCUT_PATH="/usr/local/bin/blex-wall"

echo "🚀 BlexTech Wallpaper Manager: Starting Deep Install..."

# 1. Install Dependencies (Detects Arch, Debian/Ubuntu, or Fedora)
echo "📦 Checking dependencies..."
if command -v pacman >/dev/null 2>&1; then
    sudo pacman -S --needed --noconfirm rofi-wayland swww
elif command -v apt >/dev/null 2>&1; then
    sudo apt update && sudo apt install -y rofi swww
elif command -v dnf >/dev/null 2>&1; then
    sudo dnf install -y rofi-wayland swww
fi

# 2. Setup Config Directory
mkdir -p "$INSTALL_PATH/Wallpapers"

# 3. Copy Script & Wallpapers
cp "$REPO_DIR/WallpaperManager.sh" "$INSTALL_PATH/WallpaperManager.sh"
chmod +x "$INSTALL_PATH/WallpaperManager.sh"

if [ -d "$REPO_DIR/Wallpapers" ]; then
    cp -rn "$REPO_DIR/Wallpapers/"* "$INSTALL_PATH/Wallpapers/"
fi

# 4. Create Global Shortcut (The "Place Everyone Has")
echo "🔗 Creating global shortcut at $SHORTCUT_PATH..."
# We use a small wrapper so it always points to the user's local config script
sudo bash -c "cat > $SHORTCUT_PATH <<EOF
#!/bin/bash
\$HOME/.config/Blex-Switcher/WallpaperManager.sh \"\$@\"
EOF"
sudo chmod +x "$SHORTCUT_PATH"

echo "---"
echo "✅ Installation Complete!"
echo "Global Command: blex-wall choose"
echo "Keybind for Hyprland: bind = \$mainMod, W, exec, blex-wall choose"
