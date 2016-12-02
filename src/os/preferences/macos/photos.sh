#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Photos"

execute "defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true" \
  "Prevent Photos from opening automatically when devices are plugged in"

killall "Photos" &>/dev/null
