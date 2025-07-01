
#!/bin/bash

# Usage: ./iterate_subdirs.sh /path/to/directory
#

FORCE=false

# Parse args
while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--force)
            FORCE=true
            shift
            ;;
        --) # end of options
            shift
            break
            ;;
        -*)
            echo "Unknown option: $1"
            exit 1
            ;;
        *)
            break
            ;;
    esac
done

# Example usage
if $FORCE; then
    echo "Force mode enabled"
else
    echo "Force mode disabled"
fi

check_and_clean() {

  is_symlink=$( [[ -L "$file" ]] && echo true || echo false )
  echo $is_symlink
    # if [[ -L "$1" ]]; then
      # echo "$1 is a symbolic link"
    # else
      # echo "$1 is not a symbolic link and FORCE = $FORCE"
    # fi
}

DIR="${1:-.}"  # Default to current directory

if [[ ! -d "$DIR" ]]; then
    echo "Error: '$DIR' is not a directory"
    exit 1
fi

check_and_clean ~/.zshrc

# Iterate over each immediate subdirectory
for subdir in "$DIR"/*/; do
    # Check if it is actually a directory (in case of no matches)
    [[ -d "$subdir" ]] || continue

    check_and_clean "~/.config/$subdir"
    # You can do more here with "$subdir"
done
