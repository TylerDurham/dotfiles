DROPBOX_DIR="$HOME/Dropbox"
WALLPAPER_DIR="$DROPBOX_DIR/wallpapers"

TOKYO_NIGHT_WALLPAPERS=(
  "2788019.jpg"
  "a_street_with_buildings_and_signs.png"
  "landscape-mountains-starry-sky-nebula-outer-space-body-of-3840x2160-3336.jpg"
  "3358359.jpg")

copy_background() {
  src_img=$1
  dest_dir=$2
  basename=${src_img##*/}

  if [[ -f "$src_img" ]]; then
    echo "Copying '$basename' to '$dest_dir'."
    cp $src_img "$dest_dir"
  fi
}

if [[ -d "$HOME/Dropbox/" ]]; then
  echo "Dropbox installed!"

  dest_dir="$HOME/.config/omarchy/backgrounds/tokyo-night"
  if [[ -d "$dest_dir" ]]; then

    # iterate over the array
    for wallpaper in "${TOKYO_NIGHT_WALLPAPERS[@]}"; do
      copy_background "$WALLPAPER_DIR/$wallpaper" "$dest_dir"
    done

  fi

else
  echo "Warning! Dropbox wallpaper folder not found."
fi
