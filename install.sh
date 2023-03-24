#!/bin/bash

# This script installs and configures a development environment on Ubuntu-based systems.

# Check if root
if [ $(id -u) -ne 0 ]; then
	echo "Please run as root user"
	exit 1
fi

# Update package list and install packages
echo "Updating package list ..."
if ! sudo apt-get update; then
	echo "Failed to update package list"
	exit 1
fi

echo "Installing packages ..."
if ! sudo apt-get install -y git wget curl neovim python3 python3-pip fzf bat exa fd-find trash-cli ripgrep mtr htop nmap tmux; then
	echo "Failed to install packages"
	exit 1
fi

# Install fnm
echo "Installing fnm ..."
if ! curl -fsSL https://fnm.vercel.app/install | bash; then
	echo "Failed to install fnm"
	exit 1
fi

# Install ZSH and Oh My ZSH
echo "Installing ZSH and Oh My ZSH ..."
if ! sudo apt-get install -y zsh; then
	echo "Failed to install ZSH"
	exit 1
fi

if ! sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
	echo "Failed to install Oh My ZSH"
	exit 1
fi

# Install Startship
echo "Installing Startship ..."
if ! curl -fsSL https://starship.rs/install.sh | bash; then
	echo "Failed to install Startship"
	exit 1
fi

# Install ZSH Plugins
echo "Installing ZSH plugins ..."
if ! git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions; then
	echo "Failed to install zsh-autosuggestions"
	exit 1
fi

if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting; then
	echo "Failed to install zsh-syntax-highlighting"
	exit 1
fi

if ! git clone https://github.com/sukkaw/zsh-gitcd.git ~/.oh-my-zsh/custom/plugins/zsh-gitcd; then
	echo "Failed to install zsh-gitcd"
	exit 1
fi

if ! git clone https://github.com/agkozak/zsh-z ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-z; then
	echo "Failed to install zsh-z"
	exit 1
fi

# Configure Git and SSH
echo "Configuring Git and SSH ..."
read -p "Please enter your GitHub username: " git_username
git config --global user.name "$git_username"

read -p "Please enter your GitHub email address: " git_email
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
if ! cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard; then
	echo "Failed to copy public key to clipboard"
	exit 1
fi

read -p "Press any key to continue once you have added the SSH key to your GitHub account ..."

# Clone dotfiles
echo "Copying dotfiles ..."
if ! cp -r ~/.dotfiles/!(.git|.gitignore) ~/; then
	echo "Failed to copy dotfiles"
	exit 1
fi

# Reload shell configuration
echo "Reloading shell configuration ..."
if ! source ~/.zshrc; then
	echo "Failed to reload shell configuration"
	exit 1
fi

echo "Setup complete!"
