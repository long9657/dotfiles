#!/usr/bin/env bash
set -e

PKGS=(
    'stow' 'bat' 'tmux' 'lsd' 'zoxide' 'fzf' 'ripgrep' 'fd' 'tree'
    'discord' 'qutebrowser' 'bob' 'python-pip' 'nodejs' 'npm' 'picom' 'xclip' 'bluez' 'bluez-utils' 'blueman'
    'jdk-openjdk' 'ttf-inconsolata-nerd' 'ttf-jetbrains-mono-nerd' 'zsh' 'tree-sitter-cli' 
#'nvidia-inst' 'kanshi' 'xwayland-satellite' 'kitty' 'kanshi'
)
AUR=('ghostty' 'postman-bin'  'ttf-comic-mono-git' 'ttf-blex-nerd-font-git'
# 'microsoft-edge-stable-bin'
)

sudo pacman -Syu --noconfirm --needed "${PKGS[@]}"
yay -S --noconfirm --needed "${AUR[@]}"

sudo systemctl enable --now bluetooth

[ ! -d "$HOME/.oh-my-zsh" ] && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

ZC=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
[ ! -d "$ZC/plugins/zsh-autosuggestions" ] && git clone https://github.com/zsh-users/zsh-autosuggestions "$ZC/plugins/zsh-autosuggestions"
[ ! -d "$ZC/plugins/zsh-syntax-highlighting" ] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZC/plugins/zsh-syntax-highlighting"
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

[ "$SHELL" != "$(which zsh)" ] && chsh -s $(which zsh)
