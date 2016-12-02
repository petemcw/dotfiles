#!/bin/bash
set -e

# SC2155
export DOTFILES_DATETIME
DOTFILES_DATETIME=$(date -u +"%Y%m%d%H%M.%S")
export DOTFILES_DEPS=${DOTFILES_DEPS:-curl gcc git grep perl sed sudo tee}
export DOTFILES_REPOSITORY=${DOTFILES_REPOSITORY:-petemcw/dotfiles}
export DOTFILES_BRANCH=${DOTFILES_BRANCH:-master}
export DOTFILES_ORIGIN=${DOTFILES_ORIGIN:-https://github.com/$DOTFILES_REPOSITORY.git}
export DOTFILES_HELPERS=${DOTFILES_HELPERS:-https://raw.githubusercontent.com/$DOTFILES_REPOSITORY/$DOTFILES_BRANCH/src/os/helpers.sh}
export DOTFILES_PATH=${DOTFILES_PATH:-"$HOME/.dotfiles"}
export DOTFILES_BACKUP_PATH=${DOTFILES_BACKUP_PATH:-"$DOTFILES_PATH/backups/$DOTFILES_DATETIME"}

# Helper functions
#------------------------------------------------------------------------------#

install_helpers(){
  local tmp=""
  tmp="$(mktemp /tmp/XXXXX)"
  # shellcheck source=/dev/null
  curl -LsSo "$tmp" "$DOTFILES_HELPERS" \
    && source "$tmp" \
    && rm -Rf "$tmp" \
    && return 0
  return 1
}

# Begin dotfiles
#------------------------------------------------------------------------------#

main() {

  # Ensure that things run relative to this file's path.
  cd "$(dirname "${BASH_SOURCE[0]}")" \
    || exit 1

  # Load helper functions
  if [[ -x "helpers.sh" ]]; then
    # shellcheck source=/dev/null
    source "helpers.sh" \
      || exit 1
  else
    install_helpers \
      || exit 1
  fi

  #----------------------------------------------------------------------------#

  clone_repo() {
    if [ ! -d "$DOTFILES_PATH" ]; then
      execute \
        "git clone --quiet --recursive -b $DOTFILES_BRANCH $DOTFILES_ORIGIN $DOTFILES_PATH" \
        "Clone dotfiles repository into $DOTFILES_PATH"
      cd "$DOTFILES_PATH"
    else
      ask_user_option "Do you want to update changes from dotfiles repository: (y/n)"
      if answer_is_yes; then
        if [ ! -d "$DOTFILES_PATH/.git" ]; then
          print_fail "The path $DOTFILES_PATH is not a Git repository"
          return 1
        fi

        cd "$DOTFILES_PATH"
        PREV_HEAD="$(git rev-parse HEAD)"
        git fetch --quiet --all 1>/dev/null
        if [[ $(git rev-parse HEAD) != "$PREV_HEAD" ]]; then
          print_fail "Repository changes were detected"
          return 1
        fi
        execute \
          "git merge --quiet origin/$DOTFILES_BRANCH 1>/dev/null \
            && git submodule update --quiet --init --recursive 1>/dev/null \
            && git clean -fd 1>/dev/null" \
          "Dotfiles repository updated"
      fi
    fi
  }

  #----------------------------------------------------------------------------#

  # Systems check
  print_talk "Welcome, let's get started"

  verify_os \
    || exit 1

  check_dependencies \
    || exit 1

  activate_sudo

  # Init repo
  clone_repo \
    || exit 1

  #----------------------------------------------------------------------------#

  cd "$DOTFILES_PATH" \
    || exit 1

  print_talk "I'm ready to run through installation"

  "$DOTFILES_PATH/src/os/create_directories.sh"
  "$DOTFILES_PATH/src/os/configure_git.sh"
  "$DOTFILES_PATH/src/os/copy_files.sh"
  "$DOTFILES_PATH/src/os/create_links.sh"
  "$DOTFILES_PATH/src/os/install/main.sh"
  "$DOTFILES_PATH/src/os/preferences/main.sh"
  "$DOTFILES_PATH/src/os/configure_zsh.sh"
  "$DOTFILES_PATH/src/os/restart.sh"
  exit
}

main "$@"
