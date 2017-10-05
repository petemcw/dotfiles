#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

system_update() {
  execute \
    "sudo apt-get -qqy update" \
    "APT (update)"
}

system_upgrade() {
  execute \
    "export DEBIAN_FRONTEND=\"noninteractive\" \
      && export DEBIAN_PRIORITY=\"critical\" \
      && sudo apt-get -o Dpkg::Options::=\"--force-confnew\" upgrade -qq -y" \
    "APT (upgrade)"
}

system_cleanup() {
  execute \
    "sudo apt-get autoremove -qq -y" \
    "APT (cleanup)"
}

system_add_key() {
  wget -qO - "$1" | sudo apt-key add - &>/dev/null
}

system_add_ppa() {
  sudo add-apt-repository -y ppa:"$1" &>/dev/null
}

system_add_source_list() {
  sudo sh -c "printf \"deb $1\ndeb-src $1\n\" >> '/etc/apt/sources.list.d/$2'"
}

package_installed() {
  dpkg -s "$1" &>/dev/null
}

package_install() {
  declare -r NAME="$1"
  declare -r HUMAN_NAME="$2"

  if ! package_installed "$NAME"; then
    execute \
      "sudo apt-get install -qq -y --allow-unauthenticated $NAME" \
      "$HUMAN_NAME"
  else
    print_okay "$HUMAN_NAME"
  fi
}

install_packages() {
  package_install "apt-utils" \
    "APT Utilities"
  package_install "bash-completion" \
    "Bash Completion Scripts"
  package_install "bc" \
    "BC Calculations"
  package_install "build-essential" \
    "Build Essential"
  package_install "curl" \
    "cURL"
  package_install "docker" \
    "Docker"
  package_install "docker-compose" \
    "Docker Compose"
  package_install "git" \
    "Git"
  package_install "lynx" \
    "Lynx"
  package_install "nodejs" \
    "Node JS"
  package_install "pandoc" \
    "Pandoc"
  package_install "python-pip" \
    "Python"
  package_install "python3-pip" \
    "Python3"
  package_install "python-setuptools" \
    "Python Setup Tools"
  package_install "python3-setuptools" \
    "Python3 Setup Tools"
  package_install "tmux" \
    "tmux"
  package_install "zsh" \
    "Zsh"
}

#------------------------------------------------------------------------------#

main() {
  export DEBIAN_FRONTEND="noninteractive"
  print_title "APT Packages"

  system_add_source_list \
    "https://deb.nodesource.com/node_7.x xenial main" \
    "nodesource.list"

  system_update
  system_upgrade
  printf "\n"
  install_packages
  printf "\n"
  system_cleanup
}

main
