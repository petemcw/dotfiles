#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

create_directories() {
  declare -a DIRECTORIES=(
    "$HOME/.ssh"
    "$HOME/.composer"
  )

  for i in "${DIRECTORIES[@]}"; do
    mkdir -p "$i"
  done
}

#------------------------------------------------------------------------------#

main() {
  create_directories
}

main
