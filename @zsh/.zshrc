source ~/.zsh_aliases

# ==========================================================================================
# tmux
# ==========================================================================================
if [[ ! -f ~/.config/tmux/plugins/tpm/tpm && -d ~/.config/tmux ]]; then
    echo "TPM not installed. Installing"
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
    echo 'TPM installed. Run tmux and type CTRL + <SPACE>, then "I".'
fi

export STARSHIP_CONFIG=~/.config/starship/starship.toml

eval "$(starship init zsh)"
