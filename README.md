# DOTFILES

I use either [yadm] (on a server) or [stow] (on a desktop/laptop) to manage my dotfiles. 

``` sh 
yadm clone https://github.com/TylerDurham/dotfiles.git
```

or 

``` sh 
stow -S . -t ~/
```


[yadm]:https://yadm.io/
[stow]:https://www.gnu.org/software/stow/
