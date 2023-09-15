#!/usr/bin/env sh

mkdir $HOME/Development
mkdir $HOME/Git

git config --global user.name "ThanHenderson"
git config --global user.email "nathan.t.henderson@outlook.com"

# General Tools
sudo dnf install -y neovim python3-neovim
sudo dnf install -y htop
sudo dnf install -y perf
sudo dnf install -y ninja-build
sudo dnf install -y gh
sudo dnf install -y bat 
sudo dnf install -y sqlite 

# Shell
sudo dnf install -y zsh
sudo dnf install -y util-linux-user
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

# Terminal
sudo dnf install cmake freetype-devel fontconfig-devel libxcb-devel libxkbcommon-devel g++
git clone https://github.com/alacritty/alacritty.git $HOME/alacritty
cd $HOME/alacritty
cargo build --release
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd $HOME
rm -rf $HOME/alacritty

# ssh
hostnamectl hostname 6a756e
ssh-keygen -t ed25519 -a 100

# GitHub
gh auth login

# dotfiles
git clone git@github.com:ThanHenderson/dotfiles.git $HOME/.dotfiles
rm $HOME/.zshrc && ln -s $HOME/.dotfiles/linux/.zshrc $HOME/.zshrc
ln -s $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/linux/.vimrc $HOME/.vimrc
ln -s $HOME/.dotfiles/.config/nvim $HOME/.config/nvim
ln -s $HOME/.dotfiles/.config/htop $HOME/.config/htop
ln -s $HOME/.dotfiles/.config/alacritty $HOME/.config/alacritty
rm $HOME/.p10k.zsh && ln -s $HOME/.dotfiles/linux/.p10k.zsh $HOME/.p10k.zsh

# Languages
sudo dnf install -y clang
sudo dnf install -y llvm

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

mkdir $HOME/tmpgo && cd $HOME/tmpgo
curl --proto '=https' --tlsv1.2 -sSfLkO https://go.dev/dl/go1.20.linux-amd64.tar.gz
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz
cd $HOME
rm -rf $HOME/tmpgo

# Docker configure - https://docs.docker.com/engine/install/fedora/
sudo dnf remove -y docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-selinux \
    docker-engine-selinux \
    docker-engine
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo groupadd docker
sudo usermod -aG docker $USER

# K8s
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Flatpaks
flatpak install flathub -y org.gnome.Extensions
flatpak install flathub -y com.discordapp.Discord
flatpak install flathub -y com.slack.Slack
flatpak install flathub -y org.gimp.GIMP

#VSCode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code] name=Visual Studio Code baseurl=https://packages.microsoft.com/yumrepos/vscode enabled=1 gpgcheck=1 gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf update
sudo dnf install -y code
