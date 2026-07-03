#!/usr/bin/env bash
set -e

PKGS=(
    'stow' 'bat' 'tmux' 'lsd' 'zoxide' 'fzf' 'ripgrep' 'fd' 'tree'
    'qutebrowser' 'bob' 'python-pip' 'nodejs' 'npm' 'xclip' 'bluez' 
    'bluez-utils' 'blueman' 'jdk-openjdk' 'ttf-inconsolata-nerd' 
    'ttf-jetbrains-mono-nerd' 'zsh' 'tree-sitter-cli' 'kitty' 
    'kanshi' 'ghostty' 'flatpak'
)

sudo pacman -Syu --noconfirm --needed "${PKGS[@]}"

sudo systemctl enable --now bluetooth

[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZC=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
[ ! -d "$ZC/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZC/plugins/zsh-autosuggestions"
[ ! -d "$ZC/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZC/plugins/zsh-syntax-highlighting"
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

[ "$SHELL" != "$(which zsh)" ] && chsh -s $(which zsh)

flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.getpostman.Postman
flatpak install -y flathub com.github.tchx84.Flatseal

flatpak override --user --socket=wayland
flatpak override --user --env=ELECTRON_OZONE_PLATFORM_HINT=auto
