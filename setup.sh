#!/bin/bash
set -e

require() {
	command -v "${1}" &>/dev/null && return 0
	printf 'Missing required application: %s\n' "${1}" >&2
	return 1
}

if ! require brew; then
	echo "Installing Hombrew"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! require starship; then
	# Install Startship
	echo "Installing Startship ..."
	if ! curl -fsSL https://starship.rs/install.sh | sh; then
		echo "Failed to install Startship"
		exit 1
	fi
fi

if [[ ! -d "$HOME/.local/bin" ]]; then
	mkdir -p "$HOME/.local/bin"
fi

if [[ ! -d "$HOME/.ssh" ]]; then
	mkdir "$HOME/.ssh"
	touch "$HOME/.ssh/authorized_keys"
	chmod 600 "$HOME/.ssh"
	chmod 644 "$HOME/.ssh/authorized_keys"
fi

if [[ -d "$HOME/.config/fish" ]]; then
	mv "$HOME/.config/fish" "$HOME/.config/fish.bak"
fi

packages="cmake git wget curl tmux unzip rar fish"
echo "need packages: $packages"
read -rp "Have you installed the package yet? [y/N] " confirm
if [[ "$confirm" != "y" ]]; then
	echo "Please install the packages first"
	exit 1
fi

# link dotfile to ~/.config

SOURCE_DIR="$HOME/.dotfiles/.config"
TARGET_DIR="$HOME/.config"

echo "Creating symlinks from $SOURCE_DIR to $TARGET_DIR..."

for item in "$SOURCE_DIR"/*; do
	item_name=$(basename "$item")

	target_path="$TARGET_DIR/$item_name"

	if [ -e "$target_path" ]; then
		echo "WARNING: $target_path already exists, skipping..."
	else
		ln -s "$item" "$target_path"
		echo "Created symlink: $target_path -> $item"
	fi
done

ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# Git ssh
read -rp "Need to configure git? [y/N] " confirm
if [[ "$confirm" == "y" ]]; then
	git_email="$(git config user.email)"
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

	read -rp "Press any key to continue once you have added the SSH key to your GitHub account ..."
fi
