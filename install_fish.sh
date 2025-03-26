#!/bin/bash

# Check if root
if [ "$(id -u)" -ne 0 ]; then
	echo "Please run as root user"
	exit 1
fi

packages="git wget curl fzf bat exa trash-cli ripgrep mtr htop tmux unzip rar fish fd-find iperf3 jq"
echo "need packages: $packages"
read -p "Have you installed the package yet? [y/N] " confirm
if [[ "$confirm" != "y" ]]; then
	echo "Please install the packages first"
	exit 1
fi

if [[ ! -d "$HOME/.local/bin" ]]; then
	mkdir -p "$HOME/.local/bin"
fi

# Configure Git and SSH
echo "Configuring Git and SSH ..."
read -p -r "Please enter your GitHub username: " git_username
git config --global user.name "$git_username"

read -p -r "Please enter your GitHub email address: " git_email
git config --global user.email "$git_email"

echo "Generating new SSH key for $git_email ..."
if ! ssh-keygen -t ed25519 -C "$git_email"; then
	echo "Failed to generate SSH key"
	exit 1
fi

echo "Starting ssh-agent in the background ..."
if ! eval "$(ssh-agent -s)"; then
	echo "Failed to start ssh-agent"
	exit 1
fi

if ! ssh-add ~/.ssh/id_ed25519; then
	echo "Failed to add SSH key to ssh-agent"
	exit 1
fi

echo "Copying public key to clipboard, please paste it into your GitHub account settings ..."
if ! cat ~/.ssh/id_ed25519.pub; then
	echo "Failed to copy public key to clipboard"
	exit 1
fi

read -p -r "Press any key to continue once you have added the SSH key to your GitHub account ..."

# Install Startship
echo "Installing Startship ..."
if ! curl -fsSL https://starship.rs/install.sh | sh; then
	echo "Failed to install Startship"
	exit 1
fi

# link dotfile to ~
ln -s ~/.dotfiles/.config/kitty ~/.config/kitty
ln -s ~/.dotfiles/.config/ghostty ~/.config/ghostty
ln -s ~/.dotfiles/.config/nvim ~/.config/nvim
ln -s ~/.dotfiles/.config/starship.toml ~/.config/starship.toml
ln -s ~/.dotfiles/.config/tmux ~/.config/tmux
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

cp -r ~/.dotfiles/.config/mpv ~/.config/mpv
cp -r ~/.dotfiles/.config/ni ~/.config/ni

# link fish config
ln -s ~/.dotfiles/.config/fish ~/.config/fish

fish
