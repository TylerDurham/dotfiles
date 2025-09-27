#!/usr/bin/python3

import json
import os
import shutil

HOME_DIR = os.path.expanduser("~")
WAYBAR_SRC_DIR = os.path.join(HOME_DIR, ".local/share/omarchy/config/waybar")
WAYBAR_CONFIG_DIR = os.path.join(HOME_DIR, ".config/waybar")
WAYBAR_CONFIG_FILE = os.path.join(WAYBAR_CONFIG_DIR, "config.jsonc")
WAYBAR_CSS_FILE = os.path.join(WAYBAR_CONFIG_DIR, "style.css")
MODULES = ["modules-left", "modules-center", "modules-right"]
MODULE_DEFINITIONS = ["hyprland/window", "clock", "power-profiles-daemon", "custom/tailscale"]

# Copy over original omarchy waybar config
os.makedirs(os.path.dirname(WAYBAR_CONFIG_FILE), exist_ok=True)
shutil.copytree(WAYBAR_SRC_DIR, WAYBAR_CONFIG_DIR, dirs_exist_ok=True)

# Open src waybar
with open("./update-waybar.jsonc", "r") as file:
    src_config = json.load(file)

# Open dest waybar
with open(WAYBAR_CONFIG_FILE, "r") as file:
    dest_config = json.load(file)

# Loop through each defined submodule
for submodules in MODULES:
    print(submodules)
    for module in src_config[submodules]:
      print(f"\t{module}")
      # Replace if node doesn't exist
      if dest_config.get(module) is None:
        dest_config[submodules].append(module)

# Replace module definitions
for definition in MODULE_DEFINITIONS:
    print(definition)
    dest_config[definition] = src_config[definition]

# Write new file
with open(WAYBAR_CONFIG_FILE, "w") as file:
  json.dump(dest_config, file, indent=4)

xtra_css = """

#power-profiles-daemon, #clock, #window {
    min-width: 12px;
    margin-left: 10px;
    margin-right: 12px;
}

#custom-tailscale {
  min-width: 12px;
  margin-left: 7px;
  margin-right: 7px;
}

"""
# Write additional CSS
with open(WAYBAR_CSS_FILE, "a") as file:
  file.write(xtra_css)
