export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # Loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # Optional: Loads nvm bash_completion

# if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#     eval "$(ssh-agent -s)"
#     ssh-add -l >/dev/null || ssh-add ~/.ssh/id_ed25519
# fi

# Put this in ~/.zshrc
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

if ! pgrep -u "$USER" ssh-agent > /dev/null 2>&1 || ! [ -S "$SSH_AUTH_SOCK" ]; then
    rm -f "$SSH_AUTH_SOCK" # cleanup stale socket
    eval "$(ssh-agent -a "$SSH_AUTH_SOCK" -s)" > /dev/null
    ssh-add -l >/dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519
fi

# Path for flatpak stuff
PATH=$PATH:~/.local/share/flatpak/exports/share
PATH=$PATH:/var/lib/flatpak/exports/share
