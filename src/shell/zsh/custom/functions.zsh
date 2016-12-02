#!/bin/zsh

#------------------------------------------------------------------------------#

# Show local IP address
function ips {
  ifconfig | grep "inet " | awk '{ print $2 }'
}

#------------------------------------------------------------------------------#

# Looks up current public IP address
function myip {
  res=$(curl -s jsonip.com | grep -Eo '[0-9\.]+')
  echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

#------------------------------------------------------------------------------#

# Makes a directory and changes to it.
function mkdcd {
  if [ -n "$*" ]; then
    mkdir -p "$@"
    #      └─ make parent directories if needed

    cd "$@" \
      || exit 1
  fi
}

#------------------------------------------------------------------------------#

# Finds files and executes a command on them.
function find-exec {
  find . -type f -iname "*${1:-}*" -exec "${2:-file}" '{}' \;
}

#------------------------------------------------------------------------------#

# Displays user owned processes status.
function psu {
  ps -U "${1:-$USER}" -o 'pid,%cpu,%mem,command' "${(@)argv[2,-1]}"
}

#------------------------------------------------------------------------------#

# Show top CPU/Memory hogging processes
function memcpu() {
  echo "\n*** Top 10 CPU eating processes ***";
  ps auxc | sort -nr -k 3 | head -10;
  echo "\n";
  echo "*** TOP 10 memory eating processes ***";
  ps auxc | sort -nr -k 4 | head -10;
}

#------------------------------------------------------------------------------#

# Create data URI from a file.
datauri() {
  local mimeType=""

  if [ -f "$1" ]; then
    mimeType=$(file -b --mime-type "$1")
    #                └─ do not prepend the filename to the output

    if [[ $mimeType == text/* ]]; then
      mimeType="$mimeType;charset=utf-8"
    fi

    printf "data:%s;base64,%s" \
      "$mimeType" \
      "$(openssl base64 -in "$1" | tr -d "\n")"
  else
    printf "%s is not a file.\n" "$1"
  fi
}

#------------------------------------------------------------------------------#

# Search history.
qh() {
  #           ┌─ enable colors for pipe
  #           │  ("--color=auto" enables colors only if
  #           │  the output is in the terminal)
  grep --color=always "$*" "$HISTFILE" |       less -RX
  # display ANSI color escape sequences in raw form ─┘│
  #       don't clear the screen after quitting less ─┘
}

#------------------------------------------------------------------------------#

# Search for text within the current directory.
qt() {
  grep -ir --color=always "$*" . | less -RX
  #     │└─ search all files under each directory, recursively
  #     └─ ignore case
}
