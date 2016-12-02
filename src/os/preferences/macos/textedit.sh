#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "TextEdit"

execute "defaults write com.apple.TextEdit PlainTextEncoding -int 4 \
      && defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4" \
  "Open and save files as UTF-8 encoded"

execute "defaults write com.apple.TextEdit RichText 0" \
  "Use plain text mode for new documents"

killall "TextEdit" &>/dev/null
