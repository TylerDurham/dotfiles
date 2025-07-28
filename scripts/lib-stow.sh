readonly FLG_EXISTS=1
readonly FLG_IS_DIR=2
readonly FLG_IS_FILE=4
readonly FLG_IS_SYMLINK=8
readonly FLG_CAN_BACKUP=16
readonly FLG_CAN_OVERWRITE=32

get-stow-flags() {
  full_path=$1
  overwrite=$2
  backup=$3

  local flags=0

  if [[ -d "$full_path" ]]; then
    flags=$((flags | FLG_EXISTS))     # Set the "exists" bit.
    flags=$((flags | FLG_IS_DIR))     # Set the "directory" bit.
    flags=$((flags | FLG_CAN_BACKUP)) # Set the "backup" bit.

    echo $flags
    return
  fi

  if [[ -f "$full_path" ]]; then
    flags=$((flags | FLG_EXISTS))     # Set the "exists" bit.
    flags=$((flags | FLG_IS_FILE))    # Set the "file" bit.
    flags=$((flags | FLG_CAN_BACKUP)) # Set the "backup" bit.
    echo $flags
    return
  fi

  if [[ -L "$full_path" ]]; then
    flags=$((flags | FLG_EXISTS))        # Set the "exists" bit.
    flags=$((flags | FLG_IS_SYMLINK))    # Set the "symlink" bit.
    flags=$((flags & ~FLG_CAN_BACKUP))   # Clear the "backup" bit. Why backup a symlink?
    flags=$((flags | FLG_CAN_OVERWRITE)) # Set the "overwrite" bit.
    echo $flags
    return
  fi

}

stow-recursive() {
  BASE_DIR=$1
  TARGET_DIR=$2

  echo $TARGET_DIR

  # Check if directory exists
  if [[ ! -d "$BASE_DIR" ]]; then
    error "Directory $BASE_DIR does not exist."
    exit 1
  fi

  task-list "Stowing recursively starting from '$(green $BASE_DIR)':"

  # Iterate over subdirectories
  for dir in "$BASE_DIR"/*/; do

    # Skip if not a directory
    [[ -d "$dir" ]] || continue

    # Remove trailing slash and get the name
    dirname=$(basename "$dir")

    subtask "Stowing module: '$dirname'."
    stow "$dirname" -d "$BASE_DIR" -t ~/
    #echo -e "\t'--no-stow' option passed. Not actually stowing module: '$dirname'."
  done
}
