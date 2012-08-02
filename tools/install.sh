#!/usr/bin/env bash

echo "Cloning repository to ~/.dotfiles"
git clone https://github.com/petemcw/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
echo "Initializing Git sub-modules"
git submodule init
git submodule update
echo "Backing up current files"
rake backup
echo "Creating new symlinks"
rake install
