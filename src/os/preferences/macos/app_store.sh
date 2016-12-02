#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "App Store"

execute "defaults write com.apple.appstore WebKitDeveloperExtras -bool true" \
  "Enable the Developer Tools in App Store"

execute "defaults write com.apple.appstore ShowDebugMenu -bool true" \
  "Enable the Debug Menu in App Store"

execute "defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1" \
  "Download newly available updates in background"

execute "defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1" \
  "Install System data files and security updates"

killall "App Store" &>/dev/null
