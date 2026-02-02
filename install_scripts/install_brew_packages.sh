#!/usr/bin/env bash

set -e

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
    "htop"
    "wget"
    "curl"
    "stow"
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
