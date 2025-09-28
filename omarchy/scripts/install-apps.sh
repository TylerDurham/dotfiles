sudo pacman -Sy lsd stow bat tree ripgrep fzf tmux --noconfirm


sudo pacman -Sy flatpak --noconfirm

flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub com.plexamp.Plexamp
flatpak install -y flathub com.github.johnfactotum.Foliate
sudo flatpak override com.plexamp.Plexamp --socket=wayland
sudo flatpak override com.plexamp.Plexamp --env=GDK_BACKEND=wayland
sudo flatpak override com.plexamp.Plexamp --env=ELECTRON_ENABLE_WAYLAND=1
