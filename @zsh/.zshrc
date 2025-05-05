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
