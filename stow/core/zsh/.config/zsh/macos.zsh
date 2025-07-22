# =======================================================================================
# Additional exports
# =======================================================================================

# MSQL Client path
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# NODE STUFF
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"                                       # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

# Use latest ruby interpreter on macOS
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
