#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Chrome"

execute "defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false" \
  "Disable backswipe"

execute "defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true" \
  "Expand print dialog by default"

execute "defaults write com.google.Chrome DisablePrintPreview -bool true" \
  "Use system-native print preview dialog"

killall "Google Chrome" &>/dev/null
