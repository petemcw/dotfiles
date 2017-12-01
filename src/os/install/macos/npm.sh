#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

package_install() {
  declare -r NAME="$1"
  declare -r HUMAN_NAME="$2"

  execute \
    "npm install -g $NAME" \
    "$HUMAN_NAME"
}

#------------------------------------------------------------------------------#

main() {
  printf "\n"
  print_title "Node Packages"

  package_install "npm" \
    "eslint"
  package_install "npm" \
    "grunt-cli"
  package_install "npm" \
    "gulp"
  package_install "npm" \
    "NPM"
}

main
