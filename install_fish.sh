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
if ! sudo apt-get install -y git wget curl neovim python3 python3-pip fzf bat exa fd-find trash-cli ripgrep mtr htop nmap tmux unzip fish; then
	echo "Failed to install packages"
	exit 1
fi

# Install fnm
echo "Installing fnm ..."
if ! curl -fsSL https://fnm.vercel.app/install | bash; then
	echo "Failed to install fnm"
	exit 1
fi

# Install Startship
echo "Installing Startship ..."
if ! curl -fsSL https://starship.rs/install.sh | sh; then
	echo "Failed to install Startship"
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
if ! cat ~/.ssh/id_ed25519.pub; then
	echo "Failed to copy public key to clipboard"
	exit 1
fi

read -p "Press any key to continue once you have added the SSH key to your GitHub account ..."

# copy dotfiles to ~
echo "Copying dotfiles to ~ ..."

cp -r .config ~ && rm -r .config/fish && cp .config/fish/config.fish ~/.config/fish
cp .tmux.conf ~ && cp .ideavimrc ~

# install fisher
echo "Installing fisher packages ..."
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# install fisher plugins
fish -c "fisher install jethrokuan/z"
fish -c "fisher install PatrickF1/fzf.fish"
fish -c "fisher install fisher install oh-my-fish/plugin-extract"

fish