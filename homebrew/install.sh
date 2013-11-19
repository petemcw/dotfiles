#!/bin/sh
#
# This installs some of the common dependencies desired using Homebrew.

# check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)" > /tmp/homebrew-install.log
fi

# update repository
brew update

# install Homebrew packages
# 	- GNU core utilities
#	- GNU `find`, `locate`, `updatedb`, `xargs`
brew install git coreutils findutils grc spark zsh

# remove outdated versions
brew cleanup

exit 0
