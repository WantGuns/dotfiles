#!/bin/bash

die () {
    echo "Failed to configure some stuff"
    exit
}

sudo apt update && sudo apt upgrade
sudo add-apt-repository ppa:keithw/mosh-dev -y
sudo apt update

sudo apt install zsh tmux git neovim bat mosh -y    || die

# install ripgrep
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
rm -rf ripgrep_11.0.2_amd64.deb

# XDG
sudo bash -c 'cat >> /etc/profile << EOF
export XDG_CONFIG_HOME="/home/wantguns/.config"
export XDG_CACHE_HOME="/home/wantguns/.cache"
export XDG_DATA_HOME="/home/wantguns/.local/share"
EOF'

source /etc/profile

# zsh initialization
sudo bash -c 'cat > /etc/zsh/zshenv << EOF
    export ZDOTDIR="/home/wantguns/.config/zsh"
EOF'

source /etc/zsh/zshenv

# tmux's team sucks ass for not using XDG base directories
ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf

# oh-my-zsh
## autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-autosuggestions

## syntax highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.config/oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## powershell10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-/home/wantguns/.config/oh-my-zsh/custom}/themes/powerlevel10k

## while installing oh-my-zsh, it will ask whether to make zsh your default shell. for that
sudo passwd
sudo passwd wantguns

## install oh-my-zsh
export ZSH="/home/wantguns/.config/oh-my-zsh/"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
