#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

main() {
  ask_user_option "Would you like to adjust preferences: (y/n)"
  if answer_is_yes; then
    "$DOTFILES_PATH/src/os/preferences/macos/activity.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/app_store.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/chrome.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/dashboard.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/dock.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/finder.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/iterm.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/keyboard.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/language.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/mail.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/maps.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/photos.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/safari.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/terminal.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/textedit.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/trackpad.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/transmission.sh"
    "$DOTFILES_PATH/src/os/preferences/macos/ui_ux.sh"
  fi
}

main
