###########################################################################################
# ___ _   _ _    ____ ____ ___   _ ____
#  |   \_/  |    |___ |__/ |  \  | |  |
#  |    |   |___ |___ |  \ |__/ .| |__|
#
# ___  ____ _  _ ____ ____
#   /  [__  |__| |__/ |
#  /__ ___] |  | |  \ |___
#
###########################################################################################

if [[ -n "$ZSHRC_MODE" ]]; then
  echo "Running zshrc in mode: $ZSHRC_MODE"
  if [[ "$ZSHRC_MODE" == "DEBUG" ]]; then
    zmodload zsh/zprof
  fi
fi

# ALIASES
source ~/.config/zsh/aliases.zsh

# SPECIFIC PLATFORM CONFIGS
if [[ "$(uname)" == "Darwin" ]]; then
	source ~/.config/zsh/macos.zsh
else
	source ~/.config/zsh/linux.zsh
fi

# Created by newuser for 5.9
. "$HOME/.local/bin/env"

# ==========================================================================================
# ZINIT
# ==========================================================================================

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
#
# # Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

zle_highlight+=(paste:none)

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"


# if [[ "$ZSHRC_MODE" == "DEBUG" ]]; then
#   echo "Run 'zprof' to profile zsh."
# fi
