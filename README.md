# DOTFILES

I use [stow] (on a desktop/laptop) to manage my dotfiles. 

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
