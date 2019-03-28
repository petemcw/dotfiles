#!/bin/bash

homebrew_update() {
  execute \
    "brew update" \
    "Homebrew (update)"
}

homebrew_upgrade() {
  execute \
    "brew upgrade" \
    "Homebrew (upgrade)"
}

homebrew_cleanup() {
  # By default Homebrew does not uninstall older versions of formulas so, in
  # order to remove them, `brew cleanup` needs to be used.
  #
  # https://github.com/Homebrew/brew/blob/496fff643f352b0943095e2b96dbc5e0f565db61/share/doc/homebrew/FAQ.md#how-do-i-uninstall-old-versions-of-a-formula
  execute \
    "brew cleanup" \
    "Homebrew (cleanup)"
}

brew_install() {
  declare -r FORMULA_NAME="$1"
  declare -r FORMULA_HUMAN_NAME="$2"
  declare -r TAP_REPOSITORY="$3"
  declare -r BREW_CMD="$4"

  # Check if `Homebrew` is installed.
  if test ! "$(which brew)"; then
    print_fail "$FORMULA_HUMAN_NAME ('Homebrew' is not installed)"
    return 1
  fi

  # If `brew tap` needs to be executed, check if it executed correctly.
  if [ -n "$TAP_REPOSITORY" ]; then
    if ! brew tap "$TAP_REPOSITORY" &>/dev/null; then
      print_fail "$FORMULA_HUMAN_NAME ('brew tap $TAP_REPOSITORY' failed)"
      return 1
    fi
  fi

  # Install the specified formula.
  # shellcheck disable=SC2086
  if brew $BREW_CMD list "$FORMULA_NAME" &>/dev/null; then
    print_okay "$FORMULA_HUMAN_NAME"
  else
    execute \
      "brew $BREW_CMD install $FORMULA_NAME" \
      "$FORMULA_HUMAN_NAME"
  fi
}
