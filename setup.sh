#!/bin/bash
set -e

packages="cmake git wget curl tmux unzip fish"
read -rp "have you installed ${packages} yet? [y/N] " confirm
if [[ "$confirm" != "y" ]]; then
	echo "please install the packages first"
	exit 1
fi

require() {
	command -v "${1}" &>/dev/null && return 0
	read -rp "do you need to install ${1}? [y/N] " confirm
	if [[ "$confirm" != "y" ]]; then
		return 0
	fi
	return 1
}

if ! require brew; then
	bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo ""

if [[ ! -d "$HOME/.local/bin" ]]; then
	echo "mkdir .local/bin folder"
	mkdir -p "$HOME/.local/bin"
fi

if [[ ! -d "$HOME/.ssh" ]]; then
	echo "mkdir .ssh folder"
	mkdir "$HOME/.ssh"
	chmod 700 "$HOME/.ssh"

fi

if [[ ! -f "$HOME/.ssh/authorized_keys" ]]; then
	touch "$HOME/.ssh/authorized_keys"
	chmod 644 "$HOME/.ssh/authorized_keys"
fi

read -rp "plz input ur ssh public key: " pk
${pk} >>"$HOME/.ssh/authorized_keys"

if [[ -d "$HOME/.config/fish" ]]; then
	echo "mv old fish folder to fish.bak"
	mv "$HOME/.config/fish" "$HOME/.config/fish.bak"
fi

echo ""

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

echo ""

ln -s ~/.dotfiles/scripts ~/.config/scripts
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

# Git ssh
read -rp "need to configure git? [y/N] " confirm
if [[ "$confirm" == "y" ]]; then
	git_email="$(git config user.email)"
	echo "generating new SSH key for $git_email ..."
	if ! ssh-keygen -t ed25519 -C "$git_email"; then
		echo "failed to generate SSH key"
		exit 1
	fi

	echo "starting ssh-agent in the background ..."
	if ! eval "$(ssh-agent -s)"; then
		echo "failed to start ssh-agent"
		exit 1
	fi

	if ! ssh-add ~/.ssh/id_ed25519; then
		echo "failed to add SSH key to ssh-agent"
		exit 1
	fi

	echo "copying public key to clipboard, please paste it into your GitHub account settings ..."
	if ! cat ~/.ssh/id_ed25519.pub; then
		echo "failed to copy public key to clipboard"
		exit 1
	fi
fi
