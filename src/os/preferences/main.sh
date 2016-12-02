#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

main() {
  print_talk "OS Specific Preferences"

  "$DOTFILES_PATH/src/os/preferences/$(get_os)/main.sh"
}

main
