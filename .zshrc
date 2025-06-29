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

source ~/.config/zsh/aliases.zsh

if [[ "$(uname)" == "Darwin" ]]; then
	source ~/.config/zsh/macos.zsh
else
	source ~/.config/zsh/liux.zsh
fi

# STARSHIP
eval "$(starship init zsh)"

# ZOXIDE
eval "$(zoxide init zsh)"

# Created by newuser for 5.9
. "$HOME/.local/bin/env"


# if [[ "$ZSHRC_MODE" == "DEBUG" ]]; then
#   zprof
# fi
