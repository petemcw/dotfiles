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

# taps
brew tap homebrew/php

# install updated utilities
# - GNU core utilities
# - GNU `find`, `locate`, `updatedb`, `xargs`
brew install git coreutils findutils grc spark zsh

# common packages
brew install ack
brew install ansible
brew install dnsmasq
brew install drush
brew install git-flow
brew install heroku-toolbelt
brew install htop-osx
brew install lynx
brew install mcrypt
brew install nginx
brew install ngrok
brew install percona-server
brew install python
brew install rbenv
brew install redis
brew install ruby-build
brew install speedtest_cli
brew install sqlite
brew install subversion
brew install tmux
brew install tree
brew install vim --env-std --override-system-vim --enable-pythoninterp  --with-ruby --with-perl
# wget with IRI support
brew install wget --enable-iri

# remove outdated versions
brew cleanup

exit 0
