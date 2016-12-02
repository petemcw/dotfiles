#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

configure_git() {
  ask_user_option "Do you want to generate an SSH key: (y/n)"
  if answer_is_yes; then
    KEY_NAME=${DOTFILES_KEYNAME:-id_rsa}
    KEY_PATH="$HOME/.ssh/$KEY_NAME"

    # generate SSH key if it doesn't exist
    if [ ! -f "$KEY_PATH" ]; then
      generate_ssh_key "$KEY_PATH"
    fi

    print_warn "Please add $KEY_PATH.pub to https://github.com/settings/ssh"
  fi

  customize_config_file
}

generate_ssh_key() {
  print_ask "Please provide an email address: "
  read -e -r EMAIL_ADDRESS
  # the password prompt from `ssh-keygen` is passed through.
  ssh-keygen -t rsa -b 4096 -C "$EMAIL_ADDRESS" -f "$1" -q
  print_result $? "Generate SSH keys"
}

customize_config_file() {
  if [ ! -f "$HOME/.gitconfig" ]; then
    print_ask "What is your author name: "
    read -e -r GIT_AUTHORNAME
    print_ask "What is your author email: "
    read -e -r GIT_AUTHOREMAIL

    # replace tokens for user input
    sed -e "s/AUTHOR_NAME/$GIT_AUTHORNAME/g" -e "s/AUTHOR_EMAIL/$GIT_AUTHOREMAIL/g" \
      "$DOTFILES_PATH/src/git/gitconfig.example" > "$DOTFILES_PATH/src/git/gitconfig.copy"

    ask_user_option "Do you want to add a Github token: (y/n)"
    if answer_is_yes; then
      print_ask "What is your Github username: "
      read -e -r GITHUB_USERNAME
      print_ask "Please provide a Github token: "
      read -e -r GITHUB_TOKEN

      # replace tokens for user input
      # using perl because of differences betwen POSIX/GNU sed and newlines
      perl -i -pe "s/\[GITHUB\]/\[github\]\n\n  username = $GITHUB_USERNAME\n  token = $GITHUB_TOKEN/g" \
        "$DOTFILES_PATH/src/git/gitconfig.copy"
    else
      # replace tokens for user input
      sed -i -e 's/\[GITHUB\]//g' "$DOTFILES_PATH/src/git/gitconfig.copy"
    fi
  else
    print_warn "Git appears to already be configured, skipping '~/.gitconfig' setup"
  fi
}

#------------------------------------------------------------------------------#

main() {
  print_talk "Let's see about configuring Git"
  configure_git
}

main
