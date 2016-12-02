#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Keyboard"

execute "defaults write -g AppleKeyboardUIMode -int 3" \
  "Enable full keyboard access for all controls"

execute "defaults write -g ApplePressAndHoldEnabled -bool false" \
  "Disable press-and-hold in favor of key repeat"

execute "defaults write -g 'InitialKeyRepeat_Level_Saved' -int 10" \
  "Set delay until repeat"

execute "defaults write -g KeyRepeat -int 0" \
  "Set a blazingly fast keyboard repeat rate"

execute "defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false" \
  "Disable smart quotes"

execute "defaults write -g NSAutomaticDashSubstitutionEnabled -bool false" \
  "Disable smart dashes"

execute "defaults write com.apple.BezelServices kDim -bool true" \
  "Automatically illuminate built-in MacBook keyboard in low light"

execute "defaults write com.apple.BezelServices kDimTime -int 300" \
  "Turn off keyboard illumination when computer is not used for 5 minutes"
