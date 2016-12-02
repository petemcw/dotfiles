#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

xcode_install_commandline() {
  # Prompt user to install
  if ! xcode_is_cli_installed; then
    /usr/bin/xcode-select --install &>/dev/null
  fi

  # Wait until the commandline tools are installed.
  execute \
    "until xcode_is_cli_installed; do \
      sleep 5; \
     done" \
    "Xcode Command Line Tools"
}

xcode_install_app() {
  # Prompt user to install
  if ! xcode_is_app_installed; then
    open "macappstores://itunes.apple.com/en/app/xcode/id497799835"
  fi

  # Wait until the app is installed.
  execute \
    "until xcode_is_app_installed; do \
      sleep 5; \
     done" \
    "Xcode.app"
}

xcode_set_directory() {
  sudo /usr/bin/xcode-select -switch "/Applications/Xcode.app/Contents/Developer" &>/dev/null
  print_result $? "Make Xcode developer directory point to the appropriate location from within Xcode.app"
}

xcode_accept_license() {
  # Automatically agree to the terms of the `Xcode` license.
  sudo /usr/bin/xcodebuild -license accept &>/dev/null
  print_result $? "Agree to the terms of the Xcode licence"
}

xcode_is_cli_installed() {
  /usr/bin/xcode-select -print-path &>/dev/null
}

xcode_is_app_installed() {
  [ -d "/Applications/Xcode.app" ]
}

#------------------------------------------------------------------------------#

main() {
  print_title "Xcode"

  xcode_install_commandline
  xcode_install_app
  xcode_set_directory
  xcode_accept_license
}

main
