
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

# ==========================================================================================
# TMUX
# ==========================================================================================
if [[ ! -f ~/.config/tmux/plugins/tpm/tpm && -d ~/.config/tmux ]]; then
    echo "TPM not installed. Installing"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    echo 'TPM installed. Run tmux and type CTRL + <SPACE>, then "I".'
fi

# SPECIFIC PLATFORM CONFIGS
if [[ "$(uname)" == "Darwin" ]]; then
	source ~/.config/zsh/macos.zsh
else
	source ~/.config/zsh/linux.zsh
fi

# Created by newuser for 5.9
#. "$HOME/.local/bin/env"

# =======================================================================================
# ZINIT
# =======================================================================================

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

# Setup fzf theme
  COLOR_BG=#1e1e2e          # TODO: Move these hex values into color names
  COLOR_BG_P=#313244
  COLOR_BORDER=#313244
  COLOR_SPINNER=#f5e0dc
  COLOR_HL=#f38ba8
  COLOR_HL_P=#f38ba8
  COLOR_FG=#cdd6f4
  COLOR_FG_P=#cdd6f4
  COLOR_HEADER=#f38ba8
  COLOR_INFO=#cba6f7
  COLOR_LABLE=#cdd6f4
  COLOR_POINTER=#f5e0dc
  COLOR_PROMPT=#cba6f7
  COLOR_MARKER=#b3befe
  COLOR_SELECTED_BG=#45475a

  export FZF_DEFAULT_OPTS=" \
    --bind=ctrl-j:down \
    --bind=ctrl-k:up \
    --bind=ctrl-h:toggle-preview \
    --bind=ctrl-l:toggle-preview-wrap \
    --bind=esc:cancel \
    --preview='bat --style=numbers --color=always {} || cat {}' \
    --preview-window=right:60% \
    --color=bg+:$COLOR_BG_P,bg:$COLOR_BG,spinner:$COLOR_SPINNER,hl:$COLOR_HL \
    --color=fg:$COLOR_FG,header:$COLOR_HEADER,info:$COLOR_INFO,pointer:$COLOR_POINTER \
    --color=marker:$COLOR_MARKER,fg+:$COLOR_FG_P,prompt:$COLOR_PROMPT,hl+:$COLOR_HL_P \
    --color=selected-bg:$COLOR_SELECTED_BG \
    --color=border:$COLOR_BORDER,label:$COLOR_LABEL"

# =======================================================================================
# Shell integrations
# =======================================================================================

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

# if [[ "$ZSHRC_MODE" == "DEBUG" ]]; then
#   echo "Run 'zprof' to profile zsh."
# fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Path to GO binaries 
export PATH=$PATH:/usr/local/go/bin
