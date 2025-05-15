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

   source ~/.config/zsh/.zsh_aliases

check_recommended_commands

source ~/.config/zsh/.zsh_plugins

# OS specific configs
if [[ "$(uname)" == "Darwin" ]]; then
	source ~/.config/zsh/.zsh_macos
else
	source ~/.config/zsh/.zsh_linux
fi

# ===========================================================================================
# ENV VARIABLES
# ===========================================================================================
export XDG_CONFIG_HOME="$HOME/.config"                        # CONFIG HOME
export EDITOR="nvim"

export PATH=$PATH:~/go/bin

eval "$(uv --generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
