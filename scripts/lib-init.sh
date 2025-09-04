# Default values
INSTALL_PACKAGES=0
INSTALL_XTRAS=0
STOW_DOTFILES=0
VERBOSE=0
OS_PLATFORM=$(uname | tr "[:upper:]" [":lower:"])
OVERWRITE=0
BACKUP=0
TEST=0
ARGS="$*"

source "$(pwd)/scripts/install-lib.sh"

show_debug_command() {
  if [[ "$VERBOSE" == 1 ]]; then
    info "install.sh run with the following options:"
    debug "OS architecture: $OS_PLATFORM"
    debug "Command Line Arguments $ARGS"
    subdebug "--install-packages | -p: $INSTALL_PACKAGES"
    subdebug "--stow-dotfiles | -s: $STOW_DOTFILES"
    subdebug "--verbose | -v: $VERBOSE"
    subdebug "--force | -f: $OVERWRITE"
    subdebug "--backup | -b: $BACKUP"
    subdebug "--test | -t: $TEST"
  fi
}

show_help() {
  cat <<EOF
$(blue $(bold "Usage:")) $(basename "$0") [OPTIONS]

$(blue $(bold "Options:"))
  $(yellow "--install-packages, -p")    Install all required packages.
  $(yellow "--stow-dotfiles, -s")       Run stow to symlink configuration files.
  $(yellow "--test, -t")                Run -s and -p in 'test' mode.
  $(yellow "-f")                        Overwrite conflicting target files when stowing.
  $(yellow "-b")                        Backup conflicting target files when stowing.
  $(yellow "--help, -h")                Show this help message and exit.

$(blue $(bold "Examples:"))
  $(basename "$0") -ps                  Installs packages and stows dotfiles.
  $(basename "$0") -psf                 Installs packages, and stows dotfiles (overwrites existing dotfiles).
  $(basename "$0") --install-packages   Installs packages, but does not stow dotfiles.
  $(basename "$0") --stow-dotfiles      Stows dotfiles, but does not install packages.
EOF
}

# First, handle long options manually
while [[ "$1" == --* ]]; do
  case "$1" in
  --backup)
    BACKUP=true
    shift
    ;;
  --install-packages)
    INSTALL_PACKAGES=1
    shift
    ;;
  --stow-dotfiles)
    STOW_DOTFILES=1
    shift
    ;;
  --help)
    show_help
    exit 0
    ;;
  --test)
    echo "Coming soon"
    exit 0
    ;;
  --extras)
    INSTALL_XTRAS=1
    shift
    ;;
  --) # end of long options
    shift
    break
    ;;
  *)
    echo "Unknown option: $1"
    exit 1
    ;;
  esac
done

# Now handle short options with getopts
while getopts ":psvfbx:ht" opt; do
  case ${opt} in
  b)
    BACKUP=1
    ;;
  f)
    OVERWRITE=1
    ;;
  p)
    INSTALL_PACKAGES=1
    ;;
  s)
    STOW_DOTFILES=1
    ;;
  t)
    TEST=1
    ;;
  x)
    INSTALL_XTRAS=1
    ;;
  v)
    VERBOSE=1
    ;;
  h)
    show_help
    exit 0
    ;;
  \?)
    echo "Invalid option: -$OPTARG" >&2
    exit 1
    ;;
  esac
done
shift $((OPTIND - 1))
