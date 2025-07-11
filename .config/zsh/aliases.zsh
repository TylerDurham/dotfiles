# _______ __   __        _______  ______ ______    _____  _____ alias
#    |      \_/   |      |______ |_____/ |     \     |   |     |
#    |       |    |_____ |______ |    \_ |_____/ . __|__ |_____|
#
# ==========================================================================================
# All aliases.

# ==========================================================================================
# UTILITY
# ==========================================================================================

alias cls=clear
alias c='clear'
alias cat='bat'

# ENV VARIABLES

# alias startgnome="sudo systemctl start gdm" # TODO: Need to move this to linux
alias tsc="./node_modules/.bin/tsc"

# ==========================================================================================
#
# ENV VARIABLES
# ==========================================================================================

export MY_NERD_FONT=FiraCode

# ==========================================================================================
# LSD
# ==========================================================================================

alias ls='lsd --icon auto'
alias l='lsd --icon auto -lh'
alias ll='lsd --icon auto -lah'
alias la='lsd --icon auto -A'
alias lr='lsd --icon auto -R'
alias lg='lsd --icon auto -l --group-directories-first'

# ==========================================================================================
# GIT
# ==========================================================================================
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin main'
alias gca='git commit -a'
function gacp() {
    msg=$1
    git add . && git commit -m $msg && git push
}
alias gs='git status'
alias gcl='git clone --depth 1'

# ==========================================================================================
# VIM
# ==========================================================================================
alias vim='nvim'
alias vi='nvim'

# ==========================================================================================
# UTILITY FUNCTIONS
# ==========================================================================================

run_daily() {

    # Check if a command was provided
    if [[ -z "$1" ]]; then
        echo "Usage: run_daily 'command to run'"
        return 1
    fi

    local command_to_run="$1"

    # Get the current date in YYYY-MM-DD format
    local current_date=$(date +%Y-%m-%d)
    local last_run_dir="$HOME/tmp"
    local last_run_file="$last_run_dir/daily-run-$1.tmp"

    # echo $last_run_file

    # Make the temp directory if it doesn't exist
    if [[ ! -d "$last_run_dir" ]]; then
        mkdir -p $last_run_dir
    fi

    # Check if the file exists and read the last run date
    if [[ -f "$last_run_file" ]]; then
        local last_run_date=$(cat "$last_run_file")

        # If the dates are the same, don't run the command
        if [[ "$current_date" == "$last_run_date" ]]; then
            return 0
        fi

    fi

    # Run the command
    eval "$command_to_run"

    # Update the last run date
    echo "$current_date" >"$last_run_file"

}

# Example usage:
# run_daily "echo 'This command runs once per day'"
#

red() {
    echo "\033[1;31m$1\033[0m"
}

blue() {
    echo "\033[1;34m$1\033[0m"
}

cyan() {
    echo "\033[1;81m$1\033[0m"
}

yellow() {
    echo "\033[1;93m$1\033[0m"
}

error() {
    msg=$1
    prefix="$(red "[ERROR]")"
    echo $prefix $msg >&2
}
warn() {
    msg=$1
    prefix="$(yellow "[WARNING]")"
    echo $prefix $msg >&2
}

declare -a RECOMMENDED_COMMANDS=(
    "fzf"
    "git"
    "lsd"
    "nvim"
    "tree"
    # NOTE:Package name is ripgrep.
    "rg"
    "stow"
    "tmux"
    "tree"
    "node"
    "figlet"
    "starship"
    "pass"
    "luarocks"
    # NOTE: Formats zsh files. See config.mappings, plugins.conform for keybinding & config.
    "shfmt"
    "unzip"
    "uv"
    "yadm"
    # NOTE: zoxide
    "z"
  )

check_command() {
    local program="$1"
    local mode="${2:-recommended}" # Default to 'warn' if not specified

    if [[ ! -n $1 ]]; then
        error "Please specify a command to check for!"
        return 1
    fi

    if ! command -v "$program" >/dev/null 2>&1; then
        if [ "$mode" = "required" ]; then
            error "$(yellow $program) is required but not installed."
            return 1
        elif [[ "$mode" = "silent" ]]; then
            return 127
        else
            warn "$(blue $program) is recommended but not installed."
            return 127
        fi
    fi
}

check_recommended_commands() {
    for item in "${RECOMMENDED_COMMANDS[@]}"; do
        check_command $item warning
        # echo $item
    done
}

check_font() {
    local font="$1"
    local mode="${2:-recommended}" # Default to 'warn' if not specified

    count=$(fc-list | grep -ic "FiraCode")
    if [ $count -eq 0 ]; then
        warn "$(blue "$font") font is not installed. Terminal look might be unsightly."
    fi
}
