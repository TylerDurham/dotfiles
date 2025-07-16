# DOTFILES

pre release - use with caution

I use [stow] (on a desktop/laptop) to manage my dotfiles.

## Modules

- Core
- [Omarchy](mod-omarchy.md)

## Install

After cloning, run:

``` sh 
./install.sh
```

or 

``` sh 
stow @core -t ~/
stow @linux -t ~/
stow @macos -t ~/
```


[stow]:https://www.gnu.org/software/stow/
[Catppuccin]:https://catppuccin.com/
[Catppuccin Wallpapers]:https://github.com/zhichaoh/catppuccin-wallpapers
