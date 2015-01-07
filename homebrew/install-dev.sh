#!/bin/sh
#
# This installs some development packages using Homebrew.

echo "  Installing development brews.\n "

# taps
brew tap homebrew/php

# common packages
brew install ansible
brew install dnsmasq
brew install drush
brew install git-flow
brew install heroku-toolbelt
brew install mcrypt
brew install nginx
brew install node
brew install percona-server
brew install php55 --with-fpm --without-apache
brew install php55-ioncubeloader
brew install php55-mcrypt
brew install php55-redis
brew install redis

# remove outdated versions
brew cleanup

exit 0
