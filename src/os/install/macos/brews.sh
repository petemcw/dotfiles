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
  brew_install "gnu-sed --with-default-names" \
    "GNU Filter Utilities"
  brew_install "grc" \
    "GRC"
  brew_install "htop-osx" \
    "Top Replacement"
  brew_install "lynx" \
    "Lynx"
  brew_install "node --with-openssl" \
    "Node JS"
  brew_install "openssl" \
    "OpenSSL"
  brew_install "p7zip" \
    "7z"
  brew_install "pandoc" \
    "Pandoc"
  brew_install "peco" \
    "Peco"
  brew_install "python" \
    "Python"
  brew_install "python3" \
    "Python3"
  brew_install "rlwrap" \
    "Readline Support for PlistBuddy"
  brew_install "speedtest_cli" \
    "SpeedTest CLI"
  brew_install "ssh-copy-id" \
    "SSH Copy"
  brew_install "the_silver_searcher" \
    "The Silver Searcher"
  brew_install "tig" \
    "Tig"
  brew_install "tmux" \
    "Tmux"
  brew_install "tree" \
    "Tree"
  brew_install "unrar" \
    "unRar"
  brew_install "vim --with-python3 --enable-python3interp" \
    "Vim"
  brew_install "wget --with-iri" \
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
  brew_install "heroku-toolbelt" \
    "Heroku Toolbelt"
  brew_install "jq" \
    "JQ"
  brew_install "mcrypt" \
    "Mcrypt"
  brew_install "nginx" \
    "Nginx"
  brew_install "percona-server" \
    "Percona Server"
  brew_install "php71 --with-homebrew-curl" \
    "PHP 7.1.x" \
    "homebrew/php"
  brew_install "php71-intl php71-mcrypt php71-opcache php71-redis php71-yaml" \
    "PHP 7.1.x extensions" \
    "homebrew/php"
  brew_install "php-code-sniffer" \
    "PHP Code Sniffer"
  brew_install "phpmd" \
    "PHP Mess Detector"
  brew_install "rbenv" \
    "Ruby Version Manager"
  brew_install "ruby-build" \
    "Ruby Versions"
}

brews_native() {
  cask_install "1password" \
    "1Password"
  cask_install "adobe-creative-cloud" \
    "Adobe Creative Cloud"
  cask_install "alfred" \
    "Alfred"
  cask_install "backblaze" \
    "Backblaze"
  cask_install "bartender" \
    "Bartender"
  cask_install "daisydisk" \
    "DaisyDisk"
  cask_install "docker" \
    "Docker for Mac"
  cask_install "dropbox" \
    "DropBox"
  cask_install "evernote" \
    "Evernote"
  cask_install "flux" \
    "Flux"
  cask_install "google-backup-and-sync" \
    "Google Backup"
  cask_install "google-chrome" \
    "Google Chrome"
  cask_install "handbrake" \
    "HandBrake"
  cask_install "iterm2" \
    "iTerm2"
  cask_install "kindle" \
    "Kindle"
  cask_install "microsoft-office" \
    "Microsoft Office"
  cask_install "moom" \
    "Moom"
  cask_install "paste" \
    "Paste"
  cask_install "postman" \
    "Postman"
  cask_install "sequel-pro" \
    "Sequal Pro"
  cask_install "slack" \
    "Slack"
  cask_install "spotify" \
    "Spotify"
  cask_install "sublime-text" \
    "Sublime Text 3"
  cask_install "superduper" \
    "Superduper!"
  cask_install "transmission" \
    "Transmission"
  cask_install "transmit" \
    "Transmit"
  cask_install "tunnelbear" \
    "TunnelBear"
  cask_install "tunnelblick" \
    "Tunnelblick"
  cask_install "visual-studio-code" \
    "Visual Studio Code"
  cask_install "vlc" \
    "VLC"
}

brews_fonts() {
  font_install "font-consolas-for-powerline" \
    "Consolas Font"
  font_install "font-dejavu-sans-mono-for-powerline" \
    "DejaVu Font"
  font_install "font-fira-code" \
    "Fira Code Font"
  font_install "font-hack" \
    "Hack Font"
  font_install "font-inconsolata-for-powerline" \
    "Inconsolata Font"
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
    brews_fonts
  fi

  printf "\n"
  ask_user_option "Would you like to install native Mac OS apps: (y/n)"
  if answer_is_yes; then
    printf "\n"
    print_title "Native Apps"
    brews_native
  fi

  printf "\n"
  homebrew_cleanup
}

main
