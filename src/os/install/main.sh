#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

main() {
  print_talk "I will install all the things"

  "$DOTFILES_PATH/src/os/install/$(get_os)/main.sh"
  "$DOTFILES_PATH/src/os/install/$(get_os)/powerline.sh"
  "$DOTFILES_PATH/src/os/install/vim.sh"
  "$DOTFILES_PATH/src/os/install/npm.sh"
}

main
