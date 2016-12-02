#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

configure_zsh() {
  # zsh is one of the dotfile dependencies, so will be available.
  local SHELL
  SHELL=$(which zsh)
  if ! grep -Fq "$SHELL" /etc/shells; then
    echo "$SHELL" | sudo tee -a /etc/shells &>/dev/null
    print_result $? "Add $SHELL as a valid login shell"
  fi

  sudo chsh -s "$SHELL" "$(whoami)" &>/dev/null
  print_result $? "Set default login shell"
}

#------------------------------------------------------------------------------#

main() {
  print_talk "Let's make sure you are running zsh"
  configure_zsh
}

main
