source ~/.local/share/dtd/shell/zsh.rc.sh

if [[ -e "$HOME/.local/share/../bin/env" ]]; then
. "$HOME/.local/share/../bin/env"
fi

fpath+=~/.zfunc; autoload -Uz compinit; compinit

zstyle ':completion:*' menu select
