#!/bin/sh
#
# This installs some of the common dependencies desired using Homebrew.

# check for Homebrew
if test ! $(which brew)
then
  echo "  Installing Homebrew for you.\n"
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi

echo "  Updating brews.\n "

# update repository
brew update

# install updated utilities
# - GNU core utilities
# - GNU `find`, `locate`, `updatedb`, `xargs`
brew install git coreutils findutils grc spark zsh
brew install gnu-sed --with-default-names

# common packages
brew install ack
brew install bash-completion
brew install htop-osx
brew install lynx
brew install ngrok
brew install python
brew install rbenv
brew install ruby-build
brew install speedtest_cli
brew install sqlite
brew install the_silver_searcher
brew install tmux
brew install tree
brew install vim --env-std --override-system-vim --enable-pythoninterp  --with-ruby --with-perl
# wget with IRI support
brew install wget --enable-iri

# remove outdated versions
brew cleanup

exit 0
