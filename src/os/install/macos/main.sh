#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

main() {
  "$DOTFILES_PATH/src/os/install/macos/xcode.sh"
  "$DOTFILES_PATH/src/os/install/macos/homebrew.sh"
  "$DOTFILES_PATH/src/os/install/macos/brews.sh"
}

main
