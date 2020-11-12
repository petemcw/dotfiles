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
alias composer='COMPOSER_MEMORY_LIMIT=-1 composer'

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

function phpsize {
  ps --no-headers -o "rss,cmd" -C ${1:-php-fpm} | awk '{ sum+=$1 } END { printf ("%d%s\n", sum/NR/1024,"M") }'
}

#------------------------------------------------------------------------------#
# Composer

alias c='composer'
alias ci='composer install --prefer-dist --no-interaction --no-dev'
alias cr='composer require --prefer-dist'
alias cu='composer update --prefer-dist --no-dev'

#------------------------------------------------------------------------------#
# Render Markdown files in terminal

function mdv {
  pandoc $1 | lynx -stdin
}

#------------------------------------------------------------------------------#
# Drupal
alias drupalcs="~/.composer/vendor/bin/phpcs --colors --standard=~/.composer/vendor/drupal/coder/coder_sniffer/Drupal --extensions=php,module,inc,install,test,profile,theme,js,css,info,txt,md"
alias drupalcbf="~/.composer/vendor/bin/phpcbf --standard=~/.composer/vendor/drupal/coder/coder_sniffer/Drupal --extensions='php,module,inc,install,test,profile,theme,js,css,info,txt,md'"

#------------------------------------------------------------------------------#
# Magento

alias m="bin/magento"
alias ccjs="cache-clean.js"
alias mage-perms="find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \; && chmod u+x bin/magento"
alias mcc="rm -rf generated/code generated/metadata var/view_preprocessed/pub pub/static/adminhtml pub/static/frontend pub/static/deployed_version.txt"
alias mcf="rm -rf generated/code generated/metadata var/view_preprocessed/pub pub/static/adminhtml pub/static/frontend pub/static/deployed_version.txt && ccjs all"
alias mcg="rm -rf generated/code generated/metadata var/view_preprocessed/pub pub/static/adminhtml pub/static/frontend pub/static/deployed_version.txt && cd tools && gulp styles && cd.. && ccjs all"
alias fpc-test="grep -rl -e 'cacheable=\"false\"' *"

#------------------------------------------------------------------------------#
# Docker

alias d="docker"
alias dcom="docker-compose"
alias dv="docker volume"

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
  docker rm $(docker ps -a -f status=exited -q)
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
  #docker rmi $(docker images |grep "^<none>" |awk '{ print $3 }')
  docker rmi $(docker images -f dangling=true -q)
}

# Remove all orphaned volumes (> v1.9)
function drmv {
  docker volume rm $(docker volume ls -qf dangling=true)
}

# Remove all volumes by pattern
function drmvp {
  docker volume ls |grep "$1" |awk '{print $2}' |xargs docker volume rm
}

# Reclaim space inside Docker Desktop VM
function dclean {
  docker run --privileged --pid=host docker/desktop-reclaim-space
  ls -klsh ~/Library/Containers/com.docker.docker/Data/vms/0/data/Docker.raw
}
