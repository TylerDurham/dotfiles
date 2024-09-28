# dtd-sway

My sway window manager config, based on the [Catppuccin] `mocha` theme. Includes theming for [Waybar]. 

# Features

- Catpuccin Mocha theme configured for `swaymsg`, `swaynag`, `sway`, `rofi`, `waybar`, and `dunst`.
- Screenshot script & keybindings.

![A screenshot of the sway theme](https://github.com/TylerDurham/dtd-sway/blob/main/media/screenshot1.png?raw=true)

# Installation

## Basic Way

Clone the repo to your system. Run the `install.sh` script. This will copy key directories (`sway`, `roki`, `waybar`, etc.) into your `~/.config` directory.

## Local Development

Clone the repo to your favorite local `development` directory. Use the [GNU] [stow] utility to setup symbolic links in your `~/.config` directory. 

``` sh
git clone https://github.com/TylerDurham/dtd-sway.git

cd dtd-sway

stow . -t ~/
```

# Uninstall

To uninstall, symply remove the symbolic links in your `~/.config` directory or run the `uninstall.sh` script.

``` sh
rm ~/.config/sway
rm ~/.config/waybar
rm ~/.config/swaynag
rm ~/.config/rofi
rm ~/.config/dunst
```

[GNU]: https://www.gnu.org/
[stow]: https://www.gnu.org/software/stow/
[Catppuccin]: https://catppuccin.com/
[Waybar]: https://github.com/Alexays/Waybar 
