#!/bin/bash
set -e

require() {
	command -v "${1}" &>/dev/null && return 0
	printf 'missing required application: %s\n' "${1}" >&2
	return 1
}

if ! require brew; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if ! require starship; then
	if ! curl -fsSL https://starship.rs/install.sh | sh; then
		echo -e "\nfailed to install Startship"
		exit 1
	fi
fi

if [[ ! -d "$HOME/.local/bin" ]]; then
	echo -e "mkdir .local/bin folder\n"
	mkdir -p "$HOME/.local/bin"
fi

if [[ ! -d "$HOME/.ssh" ]]; then
	echo -e "mkdir .ssh folder\n"
	mkdir "$HOME/.ssh"
	touch "$HOME/.ssh/authorized_keys"
	chmod 600 "$HOME/.ssh"
	chmod 644 "$HOME/.ssh/authorized_keys"
fi

if [[ -d "$HOME/.config/fish" ]]; then
	echo -e "mv old fish folder to fish.bak\n"
	mv "$HOME/.config/fish" "$HOME/.config/fish.bak"
fi

packages="cmake git wget curl tmux unzip rar fish"
echo "need packages: $packages"
read -rp "have you installed the package yet? [y/N] " confirm
echo -e "\n"
if [[ "$confirm" != "y" ]]; then
	echo -e "\nplease install the packages first"
	exit 1
fi

# link dotfile to ~/.config

SOURCE_DIR="$HOME/.dotfiles/.config"
TARGET_DIR="$HOME/.config"

for item in "$SOURCE_DIR"/*; do
	item_name=$(basename "$item")

	target_path="$TARGET_DIR/$item_name"

	if [ -e "$target_path" ]; then
		echo -e "WARNING: $target_path already exists, skipping..."
	else
		ln -s "$item" "$target_path"
		echo -e "Created symlink: $target_path -> $item"
	fi
done
echo -e "\n"

ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# Git ssh
read -rp "need to configure git? [y/N] " confirm
if [[ "$confirm" == "y" ]]; then
	git_email="$(git config user.email)"
	echo -e "generating new SSH key for $git_email ...\n"
	if ! ssh-keygen -t ed25519 -C "$git_email"; then
		echo "failed to generate SSH key"
		exit 1
	fi

	echo -e "starting ssh-agent in the background ...\n"
	if ! eval "$(ssh-agent -s)"; then
		echo "failed to start ssh-agent"
		exit 1
	fi

	if ! ssh-add ~/.ssh/id_ed25519; then
		echo "failed to add SSH key to ssh-agent"
		exit 1
	fi

	echo -e "copying public key to clipboard, please paste it into your GitHub account settings ...\n"
	if ! cat ~/.ssh/id_ed25519.pub; then
		echo "failed to copy public key to clipboard"
		exit 1
	fi
fi
