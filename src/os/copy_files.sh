#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

copy_files() {
  # look for all files/directories ending in ".copy".
  for SOURCE in $(find "$DOTFILES_PATH/src" -path ~/.vim -prune -o -name \*.copy)
  do
    ITEM=".$(basename ${SOURCE%.*})"
    DEST="$HOME/$ITEM"

    # item already exists
    if [[ -e "$DEST" ]]; then
      ask_user_option "Item already exists '$ITEM': What should I do? [b]ackup, [o]verwrite, [s]kip"
      if answer_is_backup; then
        mkdir -p "$DOTFILES_BACKUP_PATH" \
          && mv "$DEST" "$DOTFILES_BACKUP_PATH/"
      elif answer_is_overwrite; then
        rm -Rf "$DEST"
      else
        continue
      fi
    fi

    execute \
      "cp $SOURCE $DEST" \
      "$SOURCE → $DEST"
  done
}

#------------------------------------------------------------------------------#

main() {
  print_talk "Now I'll check if any files need to be copied"
  copy_files
}

main
