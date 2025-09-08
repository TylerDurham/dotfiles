#!/usr/bin/env bash

source "$(pwd)/scripts/lib-stow.sh"

SRC_DIR="$(pwd)/stow/extras"

is-slink() {
  if [[ -L "$1" ]]; then
    echo true
    return
  fi

  echo false
}

handle-target() {
  local target=$1
  # echo "got a target: $target"
  local base=$(basename "$target")

  if [[ -d "$target" && -L "$target" ]]; then
    # printf "$base is a directory AND a symlink."
    echo false
  elif [[ -d "$target" ]]; then
    # printf "$base is a directory."
    echo true
  elif [[ -f "$target" && -L "$target" ]]; then
    # printf "$target is a file AND a symlink."
    echo true
  elif [[ -f "$target" ]]; then
    # printf "$target is a file." 
    echo true
  fi
}

iterate-targets() {
  shopt -s nullglob dotglob
  local src=$1
  local target=$2
  for item in "$src"/*; do 
    rel_target="$target/${item#$src/}"
    flags=$(get-stow-flags "$rel_target")
    echo $flags
    if [[ -d "$item" ]]; then
      base=$(basename "$item")
      # echo "base: $base"
      iterate-targets "$item" "$target/$base"
    fi
  done
  shopt -u nullglob dotglob
}

LINKS=()

iterate-targets "$SRC_DIR/omarchy" "$HOME"

# echo "All directories: ${LINKS[@]}"

