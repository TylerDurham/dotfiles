# dotfiles

My `dotfiles`. I use [stow] to manage.

# Packages

## @sway

My sway window manager config, based on the [Catppuccin] `mocha` theme. Includes theming for [dunst], [swaylock], [swaynag], [Waybar]. 

# Features

- Catpuccin Mocha theme configured for `swaymsg`, `swaynag`, `sway`, `rofi`, `waybar`, and `dunst`.
- Screenshot script & keybindings.

![A screenshot of the sway theme](https://github.com/TylerDurham/dotfiles/blob/main/media/screenshot1.png?raw=true)

## @terminal

- Alacritty
- NeoVim
- Oh-My-Posh
- Tmux
- Zsh


# Installation

## Basic Way

Clone the repo to your system. Run the `install` script. This will copy key directories (`sway`, `rofi`, `waybar`, etc.) into your `~/.config` directory.

## Local Development

Clone the repo to your favorite local `development` directory. Use the [GNU] [stow] utility to setup symbolic links in your `~/.config` directory. 

``` sh
git clone https://github.com/TylerDurham/dotfiles

cd dotfiles 

./install
```

# Uninstall

To uninstall, symply remove the symbolic links in your `~/.config` directory or run the `uninstall` script.

``` sh
./uninstall
```

[dunst]: https://dunst-project.org/
[GNU]: https://www.gnu.org/
[stow]: https://www.gnu.org/software/stow/
[sway]: https://swaywm.org/
[Catppuccin]: https://catppuccin.com/
[Waybar]: https://github.com/Alexays/Waybar 
