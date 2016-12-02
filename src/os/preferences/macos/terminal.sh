#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Terminal"

execute "defaults write com.apple.terminal SecureKeyboardEntry -bool true" \
  "Enable 'Secure Keyboard Entry'"

execute "defaults write com.apple.Terminal ShowLineMarks -int 0" \
  "Hide line marks"

execute "defaults write com.apple.terminal StringEncodings -array 4" \
  "Only use UTF-8"
