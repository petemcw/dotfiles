#!/usr/bin/env zsh

# resource usage
alias phpsize="ps --no-headers -o \"rss,cmd\" -C php-fpm | awk '{ sum+=$1 } END { printf (\"%d%s\n\", sum/NR/1024,\"M\") }'"
alias free='free -m'

# package management
alias update="sudo apt-get -qq update && sudo apt-get upgrade"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"
alias search="apt-cache search"
