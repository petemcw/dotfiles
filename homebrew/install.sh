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

# install updated utilities
# - GNU core utilities
#	- GNU `find`, `locate`, `updatedb`, `xargs`
brew install git coreutils findutils grc spark zsh

# common packages
brew install ack
brew install ansible
brew install dnsmasq
brew install drush
brew install git-flow
brew install heroku-toolkit
brew install htop-osx
brew install lynx
brew install nginx
brew install percona-server
brew install python
brew install redis
brew install sqlite
brew install tmux
brew install tree
brew install vim --env-std --override-system-vim --enable-pythoninterp  --with-ruby --with-perl
# wget with IRI support
brew install wget --enable-iri

# remove outdated versions
brew cleanup

exit 0
