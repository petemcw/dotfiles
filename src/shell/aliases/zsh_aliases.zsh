#!/usr/bin/env zsh

# reload ZSH config
alias reload!='source ~/.zshrc'

# misc. system aliases
alias ssh='ssh -o ServerAliveInterval=60'
alias diff='diff -ubB'
alias untar='tar -zxvf'
alias zipcreate='zip -y -r -q'
alias cp_folder='cp -Rpv'
alias fixpermd='find . -type d -exec chmod 755 {} \;'
alias fixpermf='find . -type f -exec chmod 644 {} \;'

# screw-ups
alias sl='ls'

# downloads
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

# resource usage
alias df='df -kh'
alias du='du -kh'

# Serves a directory via HTTP.
alias http-serve='python -m SimpleHTTPServer'

# View HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

#------------------------------------------------------------------------------#
# Composer

alias ci='composer install --no-dev'
alias cu='composer update --no-dev'

#------------------------------------------------------------------------------#
# Render Markdown files in terminal

function mdv {
  pandoc $1 | lynx -stdin
}

#------------------------------------------------------------------------------#
# Magento

alias mage-perms="find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \; && chmod u+x bin/magento"

#------------------------------------------------------------------------------#
# Docker

alias d="docker"
alias dcom="docker-compose"

# Get latest container ID
alias dl="docker ps -l -q"

# Get container process
alias dps="docker ps"

# Get process included stop container
alias dpa="docker ps -a"

# Get images
alias di="docker images"

# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"

# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -P -d"

# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -P -it"

# Run interactive container and remove afterwards
alias dkr="dki --rm"

# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

# Stop all containers
function dstop {
  docker stop $(docker ps -a -q)
}

# Remove all containers
function drm {
  docker rm $(docker ps -a -q)
}

# Dockerfile build, e.g., dbu petemcw/test
function dbu {
  docker build -t=$1 .;
}

# Connect to a container
function dbash {
  docker exec -it $1 bash;
}

# Remove all untagged images
function drmi {
  docker rmi $(docker images |grep "^<none>" |awk '{ print $3 }')
}

# Remove all orphaned volumes (> v1.9)
function drmv {
  docker volume rm $(docker volume ls -qf dangling=true)
}
