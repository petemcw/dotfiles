#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Dashboard"

execute "defaults write com.apple.dashboard mcx-disabled -bool true" \
  "Disable Dashboard"

# Dock is the parent process of Dashboard
killall "Dock" &>/dev/null
