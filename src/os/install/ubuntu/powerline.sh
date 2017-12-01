#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

main() {
  printf "\n"
  print_title "Powerline"

  if type -t pip3 &>/dev/null; then
    execute \
      "sudo pip3 --quiet install --upgrade pip \
        && sudo pip3 --quiet install git+git://github.com/powerline/powerline \
        && sudo pip3 --quiet install psutil" \
      "Python3 (via pip)"
  elif type -t pip &>/dev/null; then
    execute \
      "sudo pip --quiet install --upgrade pip \
        && sudo pip --quiet install git+git://github.com/powerline/powerline \
        && sudo pip --quiet install psutil" \
      "Python (via pip)"
  fi
}

main
