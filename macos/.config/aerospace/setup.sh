#!/usr/bin/env bash

# SPACES
# For some reason, mission control doesn’t like that AeroSpace puts a lot of windows in the bottom right corner of the screen. Mission control shows windows too small even when there is enough space to show them bigger.
# There is a workaround. You can enable Group windows by application setting:
defaults write com.apple.dock expose-group-apps -bool true && killall Dock

# If you don’t care about macOS native fullscreen in multi-monitor setup (which is itself clunky anyway, since it creates a separate Space instance), I recommend disabling Displays have separate Spaces.
#
# You can disable the setting by running:
defaults write com.apple.spaces spans-displays -bool true && killall SystemUIServer

