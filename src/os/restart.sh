#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

main() {
  print_talk "All finished! Link in any items from Dropbox."

  ask_user_option "Do you want to restart: (y/n)"
  if answer_is_yes; then
    sudo shutdown -r now &>/dev/null
  fi
}

main
