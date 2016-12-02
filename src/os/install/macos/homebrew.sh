#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh" \
  && source "$DOTFILES_PATH/src/os/install/macos/helpers.sh"

#------------------------------------------------------------------------------#

homebrew_install() {
  if test ! $(which brew); then
    execute \
      '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" &> /dev/null' \
      "Homebrew (install)"
  fi
}

homebrew_analytics_opt_out() {
  local path=""

  # Get the path of the `Homebrew` git config file.
  path="$(homebrew_config_file_path)" \
    || return 1

  # Opt-out of Homebrew's analytics.
  # https://github.com/Homebrew/brew/blob/0c95c60511cc4d85d28f66b58d51d85f8186d941/share/doc/homebrew/Analytics.md#opting-out
  if [ "$(git config --file="$path" --get homebrew.analyticsdisabled)" != "true" ]; then
    git config --file="$path" --replace-all homebrew.analyticsdisabled true &>/dev/null
  fi

  print_result $? "Homebrew (opt-out of analytics)"
}

homebrew_config_file_path() {
  local path=""

  if path="$(brew --repository 2>/dev/null)/.git/config"; then
    printf "%s" "$path"
    return 0
  else
    print_fail "Homebrew (config file path)"
    return 1
  fi
}

#------------------------------------------------------------------------------#

main() {
  printf "\n"
  print_title "Homebrew"

  homebrew_install
  homebrew_analytics_opt_out
  homebrew_update
  homebrew_upgrade
}

main
