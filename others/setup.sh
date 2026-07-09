#!/usr/bin/env bash
set -e

PKGS=(
    'stow' 'bat' 'tmux' 'lsd' 'zoxide' 'fzf' 'ripgrep' 'fd' 'tree'
    'qutebrowser' 'bob' 'python-pip' 'nodejs' 'npm' 'bluez' 
    'bluez-utils' 'blueman' 'jdk-openjdk' 'ttf-inconsolata-nerd' 
    'ttf-jetbrains-mono-nerd' 'zsh' 'tree-sitter-cli' 'kitty' 
    'kanshi' 'ghostty' 'flatpak' 'lazygit' 'fastfetch' 'fcitx5-config-qt'
)

sudo pacman -Syu --noconfirm --needed "${PKGS[@]}"

sudo systemctl enable --now bluetooth

[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZC=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
[ ! -d "$ZC/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZC/plugins/zsh-autosuggestions"
[ ! -d "$ZC/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZC/plugins/zsh-syntax-highlighting"
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ "$SHELL" != "$(which zsh)" ]; then
    sudo chsh -s "$(which zsh)" "$USER"
fi

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.getpostman.Postman
flatpak install -y flathub com.github.tchx84.Flatseal

flatpak override --user --socket=wayland
flatpak override --user --env=ELECTRON_OZONE_PLATFORM_HINT=auto

killall ibus-daemon || true

yay -S --noconfirm --needed --ask 4 fcitx5-lotus-bin swayfx

sudo systemctl enable --now fcitx5-lotus-server@$(whoami).service || (sudo systemd-sysusers && sudo systemctl enable --now fcitx5-lotus-server@$(whoami).service)

cat << 'EOF' >> ~/.config/sway/config.d/theme
corner_radius 12
shadows on
blur enable
blur_passes 3
blur_radius 7
default_dim_inactive 0.3
EOF
