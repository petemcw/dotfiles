#!/bin/sh
#
# This installs some native OS X apps

brew tap phinze/homebrew-cask
brew install brew-cask

function installcask() {
    brew cask install "${@}" 2> /dev/null
}

installcask alfred
installcask appcleaner
installcask bartender
installcask clipmenu
installcask colloquy
installcask copy
installcask daisydisk
installcask dropbox
installcask f-lux
installcask firefox
installcask google-chrome
installcask handbrake
installcask hipchat
installcask iterm2
installcask minecraft
installcask moom
installcask plex
installcask rdio
installcask sequel-pro
installcask sketchup
installcask skype
installcask spotify
installcask sublime-text
installcask superduper
installcask transmission
installcask transmit
installcask tvshows
installcask virtualbox
installcask vlc
installcask vmware-fusion

exit 0
