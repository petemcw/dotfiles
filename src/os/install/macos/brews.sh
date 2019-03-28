#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh" \
  && source "$DOTFILES_PATH/src/os/install/macos/helpers.sh"

#------------------------------------------------------------------------------#

brews() {
  brew_install "ack" \
    "ACK"
  brew_install "git" \
    "Git"
  # - GNU core utilities
  # - GNU `find`, `locate`, `updatedb`, `xargs`
  brew_install "coreutils findutils moreutils" \
    "GNU Core Utilities"
  brew_install "ffmpeg" \
    "FFMPEG"
  brew_install "gnu-sed" \
    "GNU Filter Utilities"
  brew_install "gnu-tar" \
    "GNU Tar"
  brew_install "grc" \
    "GRC"
  brew_install "htop-osx" \
    "Top Replacement"
  brew_install "openssl" \
    "OpenSSL"
  brew_install "p7zip" \
    "7z"
  brew_install "pandoc" \
    "Pandoc"
  brew_install "powerlevel9k" \
    "Powerlevel 9k" \
    "sambadevi/powerlevel9k"
  brew_install "python" \
    "Python"
  brew_install "rlwrap" \
    "Readline Support for PlistBuddy"
  brew_install "speedtest_cli" \
    "SpeedTest CLI"
  brew_install "ssh-copy-id" \
    "SSH Copy"
  brew_install "tmux" \
    "Tmux"
  brew_install "tree" \
    "Tree"
  brew_install "unrar" \
    "unRar"
  brew_install "vim" \
    "Vim"
  brew_install "wget" \
    "Wget"
  brew_install "youtube-dl" \
    "YouTube DL"
  brew_install "z" \
    "Z"
  brew_install "zsh" \
    "Zsh"
  brew_install "zsh-completions" \
    "Zsh Completion Scripts"
}

brews_dev() {
  brew_install "git-flow" \
    "Git Flow"
  brew_install "jq" \
    "JQ"
  brew_install "php" \
    "PHP"
  brew_install "mcrypt" \
    "Mcrypt"
  brew_install "mysql-client" \
    "MySQL Client"
  brew_install "nginx" \
    "Nginx"
  brew_install "nghttp2" \
    "Nginx HTTP/2"
  brew_install "php-code-sniffer" \
    "PHP Code Sniffer"
  brew_install "php-cs-fixer" \
    "PHP Code Fixer"
}

assets_fonts() {
  cp "$DOTFILES_PATH/assets/fonts/"* ~/Library/Fonts/
}

#------------------------------------------------------------------------------#

main() {
  printf "\n"
  print_title "Homebrew Packages"
  brews

  printf "\n"
  ask_user_option "Would you like to install development packages: (y/n)"
  if answer_is_yes; then
    printf "\n"
    print_title "Development Packages"
    brews_dev
  fi

  printf "\n"
  ask_user_option "Would you like to install fonts: (y/n)"
  if answer_is_yes; then
    printf "\n"
    print_title "Fonts"
    assets_fonts
  fi

  printf "\n"
  homebrew_cleanup
}

main
