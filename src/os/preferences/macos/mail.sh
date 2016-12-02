#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Mail"

execute "defaults write com.apple.mail DisableReplyAnimations -bool true \
      && defaults write com.apple.mail DisableSendAnimations -bool true" \
  "Disable send and reply animations in Mail.app"

execute "defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false" \
  "Copy email addresses without the name"

killall "Mail" &>/dev/null
