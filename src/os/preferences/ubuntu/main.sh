#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

main() {
  ask_user_option "Would you like to adjust preferences: (y/n)"
  if answer_is_yes; then
    print_warn "No Ubuntu preferences to set"
  fi
}

main
