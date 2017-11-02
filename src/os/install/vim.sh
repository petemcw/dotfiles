#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

install_plugins() {
  declare -r VUNDLE_DIR="$HOME/.vim/bundles/Vundle.vim"
  declare -r VUNDLE_URL="https://github.com/VundleVim/Vundle.vim"

  execute \
    "rm -rf '$VUNDLE_DIR' \
      && git clone --quiet '$VUNDLE_URL' '$VUNDLE_DIR' \
      && printf '\n' | vim +PluginInstall +qall" \
    "Install plugins" \
    || return 1
}

update_plugins() {
  execute \
    "vim +PluginUpdate +qall" \
    "Update plugins"
}

#------------------------------------------------------------------------------#

main() {
  printf "\n"
  print_title "Vim"

  if [ ! -f "$HOME/.vim/bundles/Vundle.vim/README.md" ]; then
    install_plugins
  else
    update_plugins
  fi
}

main
