source ~/.local/share/dtd/shell/zsh.rc.sh

. "$HOME/.local/share/../bin/env"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
