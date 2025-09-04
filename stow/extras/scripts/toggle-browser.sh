#!/bin/zsh

# Directory to search (defaults to current directory if none provided)
# TARGET_DIR="${1:-.}"
TARGET_DIR="./pkg/.local/share/applications"

# Replacement string
REPLACEMENT=""

# default_browser=$(xdg-settings get default-web-browser)
# browser_name=${default_browser%.*}
# echo $browser_name
# exit 0

# Find and process .desktop files
find "$TARGET_DIR" -type f -name "*.desktop" | while read -r file; do
  if grep -q "Exec=brave" "$file"; then

    # Replacement string
    REPLACEMENT="Exec=chromium"
    export BROWSER="chromium"
    echo "Updating: $file"
    sed -i 's|Exec=brave|'"$REPLACEMENT"'|g' "$file"
  elif grep -q "Exec=chromium" "$file"; then
    # Replacement string
    REPLACEMENT="Exec=brave"
    export BROWSER="brave"
    echo "Updating: $file"
    sed -i 's|Exec=chromium|'"$REPLACEMENT"'|g' "$file"
  fi
done

echo "All matching .desktop files have been updated to '$BROWSER'."
