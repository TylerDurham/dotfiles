
# SPECIFIC PLATFORM CONFIGS
if [[ "$(uname)" == "Darwin" ]]; then
	source ~/.config/zsh/macos.zprofile.zsh
else
	source ~/.config/zsh/linux.zprofile.zsh
fi
