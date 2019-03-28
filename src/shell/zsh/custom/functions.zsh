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

#------------------------------------------------------------------------------#

# extract any time of compressed file
extract() {
    echo Extracting $1 ...
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1  ;;
            *.tar.gz)    tar xzf $1  ;;
            *.bz2)       bunzip2 $1  ;;
            *.rar)       rar x $1    ;;
            *.gz)        gunzip $1   ;;
            *.tar)       tar xf $1   ;;
            *.tbz2)      tar xjf $1  ;;
            *.tgz)       tar xzf $1  ;;
            *.zip)       unzip $1   ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1  ;;
            *)        echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

