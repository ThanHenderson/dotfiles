#!/usr/bin/env bash

if ! command -v brew &> /dev/null
then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

echo "Updating Homebrew..."
brew update

packages=(
    "git"
    "vim"
    "nvim"
    "htop"
    "wget"
    "curl"
    "tmux"
    "eza"
    "fzf"
    "zoxide"
    "yazi"
    "stow"
    "ripgrep"
    "bat"
    "hugo"
    "gh"
    "rlwrap"
)

echo "Installing packages..."
for package in "${packages[@]}"
do
    if ! brew list "$package" &> /dev/null
    then
        echo "Installing $package..."
        brew install "$package"
    else
        echo "$package is already installed."
    fi
done

echo "All packages installed!"
