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

# STARSHIP
eval "$(starship init zsh)"

# ZOXIDE
eval "$(zoxide init zsh --cmd cd)"


# Created by newuser for 5.9
. "$HOME/.local/bin/env"

# ==========================================================================================
# FZF
# ==========================================================================================
# Set up fzf key bindings and fuzzy completion
check_command fzf silent
if [ $? -eq 0 ]; then

  source <(fzf --zsh)

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
  --color=bg+:$COLOR_BG_P,bg:$COLOR_BG,spinner:$COLOR_SPINNER,hl:$COLOR_HL \
  --color=fg:$COLOR_FG,header:$COLOR_HEADER,info:$COLOR_INFO,pointer:$COLOR_POINTER \
  --color=marker:$COLOR_MARKER,fg+:$COLOR_FG_P,prompt:$COLOR_PROMPT,hl+:$COLOR_HL_P \
  --color=selected-bg:$COLOR_SELECTED_BG \
  --color=border:$COLOR_BORDER,label:$COLOR_LABEL"
fi


if [[ "$ZSHRC_MODE" == "DEBUG" ]]; then
  echo "Run 'zprof' to profile zsh."
fi
