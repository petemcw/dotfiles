#!/bin/bash

declare -r COLOR_RED="1"
declare -r COLOR_GREEN="2"
declare -r COLOR_YELLOW="3"
declare -r COLOR_BLUE="4"
declare -r COLOR_MAGENTA="5"
declare -r COLOR_CYAN="6"
declare -r COLOR_WHITE="7"

print_color() {
  # Using `tput` change forground color, print, reset display.
  printf "%b" \
    "$(tput setaf "$2" 2>/dev/null)" \
    "$1" \
    "$(tput sgr0 2>/dev/null)"
}

print_red() {
  print_color "$1" "$COLOR_RED"
}

print_green() {
  print_color "$1" "$COLOR_GREEN"
}

print_yellow() {
  print_color "$1" "$COLOR_YELLOW"
}

print_blue() {
  print_color "$1" "$COLOR_BLUE"
}

print_magenta() {
  print_color "$1" "$COLOR_MAGENTA"
}

print_cyan() {
  print_color "$1" "$COLOR_CYAN"
}

print_white() {
  print_color "$1" "$COLOR_WHITE"
}

print_okay() {
  print_green "     [✔] $1\n"
}

print_warn() {
  print_magenta "     [!] $1\n"
}

print_fail() {
  local message=$(printf "$1" "$2")
  print_red "     [✖] $message\n"
}

print_fail_stream() {
  while read -r line; do
    print_fail "↳ ERROR: $line"
  done
}

print_talk() {
  print_cyan "\n(ツ) $1\n\n"
}

print_title() {
  print_blue "     $1\n"
}

print_ask() {
  print_yellow "     [?] $1"
}

print_result() {
  if [ "$1" -eq 0 ]; then
    print_okay "$2"
  else
    print_fail "$2"
  fi
  return "$1"
}

#------------------------------------------------------------------------------#

ask_user() {
  print_ask "$1 "
  read -p " " -e -r
}

ask_user_secret() {
  print_ask "$1 "
  stty -echo
  trap 'stty echo' EXIT
  read -r
  stty echo
  trap - EXIT
  echo
}

ask_user_option() {
  print_ask "$1 "
  read -n 1 -e -r
}

users_answer() {
  printf "%s" "$REPLY"
}

answer_is_yes() {
  [[ "$REPLY" =~ ^[Yy]$ ]] \
    && return 0 \
    || return 1
}

answer_is_backup() {
  [[ "$REPLY" =~ ^[Bb]$ ]] \
    && return 0 \
    || return 1
}

answer_is_overwrite() {
  [[ "$REPLY" =~ ^[Oo]$ ]] \
    && return 0 \
    || return 1
}

answer_is_skip() {
  [[ "$REPLY" =~ ^[Ss]$ ]] \
    && return 0 \
    || return 1
}

#------------------------------------------------------------------------------#

is_macos() {
  local kernel_name=""
  kernel_name="$(uname -s)"
  [[ "$kernel_name" == "Darwin" ]] || return 1
}

is_ubuntu() {
  local kernel_name=""
  kernel_name="$(uname -s)"
  [[ "$kernel_name" == "Linux" ]] && [[ -e "/etc/lsb-release" ]] || return 1
}

get_os() {
  local os=""

  if is_macos; then
    os="macos"
  elif is_ubuntu; then
    os="ubuntu"
  else
    os="$kernel_name"
  fi

  printf "%s" "$os"
}

get_os_version() {
  local version=""

  if is_macos; then
    version="$(sw_vers -productVersion)"
  elif is_ubuntu; then
    version="$(lsb_release -d | cut -f2 | cut -d' ' -f2)"
  fi

  printf "%s" "$version"
}

is_supported_version() {
  declare -a v1=(${1//./ })
  declare -a v2=(${2//./ })
  local i=""

  # Fill empty positions in v1 with zeros.
  for (( i=${#v1[@]}; i<${#v2[@]}; i++ )); do
    v1[i]=0
  done

  for (( i=0; i<${#v1[@]}; i++ )); do
    # Fill empty positions in v2 with zeros.
    if [[ -z ${v2[i]} ]]; then
      v2[i]=0
    fi

    if (( 10#${v1[i]} < 10#${v2[i]} )); then
      return 1
    elif (( 10#${v1[i]} > 10#${v2[i]} )); then
      return 0
    fi
  done
}

verify_os() {
  declare -r MINIMUM_MACOS_VERSION="10.10"
  declare -r MINIMUM_UBUNTU_VERSION="14.04"
  local os_version=""

  # Check if the OS is `macOS` and it's above the required version.
  if is_macos; then
    os_version="$(sw_vers -productVersion)"

    if is_supported_version "$os_version" "$MINIMUM_MACOS_VERSION"; then
      return 0
    else
      print_fail "Unsupported version, intended only for macOS %s+" "$MINIMUM_MACOS_VERSION"
    fi
  # Check if the OS is `Ubuntu` and it's above the required version.
  elif is_ubuntu; then
    os_version="$(lsb_release -d | cut -f2 | cut -d' ' -f2)"

    if is_supported_version "$os_version" "$MINIMUM_UBUNTU_VERSION"; then
      return 0
    else
      print_fail "Unsupported version, intended only for Ubuntu %s+" "$MINIMUM_UBUNTU_VERSION"
    fi
  else
    print_fail "Unsupported OS, only macOS or Ubuntu please."
  fi

  return 1
}

check_dependencies() {
  REQUIRED_TOOLS=${DOTFILES_DEPS:-}
  MISSING_TOOLS="$(check_installed "$REQUIRED_TOOLS")"
  if (( $(echo "$MISSING_TOOLS" | wc -w) > 0 )); then
    print_fail "Missing required tools → $MISSING_TOOLS"
    return 1
  fi
}

check_installed() {
  local missed=""
  local return_code=""
  until [ -z "$1" ]; do
    return_code=$(type -t "$1" &>/dev/null)
    if (( return_code != 0 )); then
      missed="$missed $1"
    fi
    shift
  done
  echo "$missed"
}

activate_sudo() {
  print_title "Admin privileges are required, you may need to enter your password"
  sudo -v &>/dev/null
  while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
  done &>/dev/null &
}

set_trap() {
  trap -p "$1" | grep "$2" &>/dev/null \
    || trap '$2' "$1"
}

show_spinner() {
  local -r FRAMES='/-\|'
  local -r NUMBER_OR_FRAMES=${#FRAMES}
  local -r CMDS="$2"
  local -r MSG="$3"
  local -r PID="$1"
  local i=0
  local frame_text=""

  # Note: In order for the Travis CI site to display
  # things correctly, it needs special treatment, hence,
  # the "is Travis CI?" checks.
  if [ "$TRAVIS" != "true" ]; then
    # Provide more space so that the text hopefully
    # doesn't reach the bottom line of the terminal window.
    #
    # This is a workaround for escape sequences not tracking
    # the buffer position (accounting for scrolling).
    #
    # See also: https://unix.stackexchange.com/a/278888
    printf "\n\n\n"
    tput cuu 3
    tput sc
  fi

  # Display spinner while the commands are being executed.
  while kill -0 "$PID" &>/dev/null; do
    frame_text="     [${FRAMES:i++%NUMBER_OR_FRAMES:1}] $MSG"

    # Print frame text.
    if [ "$TRAVIS" != "true" ]; then
      printf "%s\n" "$frame_text"
    else
      printf "%s" "$frame_text"
    fi

    sleep 0.2

    # Clear frame text.
    if [ "$TRAVIS" != "true" ]; then
      tput rc
    else
      printf "\r"
    fi
  done
}

kill_all_subprocesses() {
  local i=""

  for i in $(jobs -p); do
    kill "$i"
    wait "$i" &>/dev/null
  done
}

execute() {
  local -r CMDS="$1"
  local -r MSG="${2:-$1}"
  local -r TMP_FILE="$(mktemp /tmp/XXXXX)"
  local exit_code=0
  local cmds_pid=""

  # If the current process is ended, also end all its subprocesses.
  set_trap "EXIT" "kill_all_subprocesses"

  # Execute commands in background.
  eval "$CMDS" \
    &>/dev/null \
    2>"$TMP_FILE" &
  cmds_pid=$!

  # Show a spinner if the commands require more time to complete.
  show_spinner "$cmds_pid" "$CMDS" "$MSG"

  # Wait for the commands to no longer be executing in the background, and then
  # get their exit code.
  wait "$cmds_pid" &>/dev/null
  exit_code=$?

  # Print output based on what happened.
  print_result $exit_code "$MSG"

  if [ $exit_code -ne 0 ]; then
    print_fail_stream < "$TMP_FILE"
  fi

  rm -rf "$TMP_FILE"

  return $exit_code
}
