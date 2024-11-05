# CONFIG HOME
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR="nvim"
 #PATH

# Oh-My-Posh
export PATH=$PATH:$HOME/.local/bin
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/sudonyms.omp.json)"
#eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/catppuccin_mocha.omp.json)"

# My aliases
source ~/.config/zsh/.zsh_aliases

# My scripts
# source ~/.scripts/*

# history setup
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward


# PLUGIN MANAGEMENT
# Download Znap, if it's not there yet.
[[ -r ~/.config/zsh/znap/znap.zsh ]] ||
    git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/.config/zsh/znap

source ~/.config/zsh/znap/znap.zsh  # Start Znap

# zsh completions directory
fpath=(~/.config/zsh/completions $fpath)

# Plugins (repos)
znap source zsh-users/zsh-autosuggestions	# Auto suggestions
znap source zsh-users/zsh-completions		# Auto completions
znap source zsh-users/zsh-syntax-highlighting	# Syntax highlighting

# NODE.JS 
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# UNCOMMENT for KVM
export LIBVIRT_DEFAULT_URI='qemu:///system'


# FZF keybindings & setup for zsh
source <(fzf --zsh)

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# OS specific
if [[ "$(uname)" == "Darwin" ]]; then
	source ~/.config/zsh/.zsh_macos
else
	source ~/.config/zsh/.zsh_linux
fi

# Let gpg know to use the terminal to avoid 
# gpg: public key decryption failed: Inappropriate ioctl for device
export GPG_TTY=$(tty)

clear

# Why not? Why SHOULDN'T I run neofetch?
fastfetch
