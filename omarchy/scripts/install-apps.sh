sudo pacman -S flatpak
sudo packman -S lsd

flatpak install -y flathub com.github.tchx84.Flatseal
flatpak install -y flathub com.plexamp.Plexamp    
sudo flatpak override com.plexamp.Plexamp --socket=wayland
sudo flatpak override com.plexamp.Plexamp --env=GDK_BACKEND=wayland
sudo flatpak override com.plexamp.Plexamp --env=ELECTRON_ENABLE_WAYLAND=1
