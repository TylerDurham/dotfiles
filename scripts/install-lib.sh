install_package() {
  local FULL_CMD="$*"

  echo -e ""$(task "Running command '$(green $FULL_CMD)'.")
  eval "$FULL_CMD"
}

stow_package() {
  # TODO: Options to override if stow target exists.
  local BASE_DIR="$1"
  local DIR_NAME="$2"

  # Example action (replace with your command)
  # echo "Running stow for $dirname"
  stow "$DIR_NAME" -d "$BASE_DIR" -t ~/
  echo -e ""$(task "Stowing dotfiles for '$(green $DIR_NAME)'.")

}

stow_packages() {

  BASE_DIR=$1

  # Check if directory exists
  if [[ ! -d "$BASE_DIR" ]]; then
    error "Directory $BASE_DIR does not exist."
    exit 1
  fi

  # Iterate over subdirectories
  for dir in "$BASE_DIR"/*/; do
    # Skip if not a directory
    [[ -d "$dir" ]] || continue

    # Remove trailing slash and get the name
    dir_name=$(basename "$dir")

    stow_package $BASE_DIR $dir_name

  done
}
