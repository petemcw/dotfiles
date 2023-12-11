#!/usr/bin/env zsh

# reload ZSH config
alias reload!='exec zsh'

# system
alias composer='COMPOSER_MEMORY_LIMIT=-1 composer.phar'
alias cpr='cp -Rpv'
alias csa='composer show --all'
alias diff='diff -ubB'
alias drush='drush.phar'
alias fixpermd='find . -type d -exec chmod 755 {} \;'
alias fixpermf='find . -type f -exec chmod 644 {} \;'
alias ls='/bin/ls -G'
alias l='ls -alhFG'
alias ll='ls -lhFG'
alias psa='ps aux'
alias ssh='ssh -o ServerAliveInterval=60'
alias untar='tar -zxvf'
alias zipcreate='zip -y -r -q'

# misspellings
alias cd..='cd ..'
alias cd...='cd ../..'
alias sl='ls'

# downloads
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

# resource usage
alias df='df -kh'
alias du='du -kh'

# View HTTP traffic
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# fzf
alias fzfp="fzf --height 40% --layout=reverse --preview 'file {}' --preview-window=right:60%:wrap"

# Drupal
alias drupalcs="phpcs --colors --standard=~/.composer/vendor/drupal/coder/coder_sniffer/Drupal --extensions=php,module,inc,install,test,profile,theme,js,css,info,txt,md"
alias drupalcbf="phpcbf --standard=~/.composer/vendor/drupal/coder/coder_sniffer/Drupal --extensions='php,module,inc,install,test,profile,theme,js,css,info,txt,md'"

# Magento
alias fpc-test="grep -rl -e 'cacheable=\"false\"' *"
alias mcc="rm -rf generated/code generated/metadata var/view_preprocessed/pub pub/static/adminhtml pub/static/frontend pub/static/deployed_version.txt"
alias mcf="rm -rf generated/code generated/metadata var/view_preprocessed/pub pub/static/adminhtml pub/static/frontend pub/static/deployed_version.txt && ccjs all"
alias m2.perms="find var vendor pub/static pub/media app/etc -type f -exec chmod g+w {} \; && find var vendor pub/static pub/media app/etc -type d -exec chmod g+w {} \; && chmod u+x bin/magento"
alias m2.reindex="ddev magento indexer:status |grep required |awk -F '|' '{print \$2}' |xargs ddev magento indexer:reindex"
alias m2.reindex.cron="ddev n98 sys:cron:run indexer_update_all_views && ddev n98 sys:cron:run indexer_clean_all_changelogs"

# Docker
alias d="docker"
alias dco="docker-compose"
alias di="docker images"                                                    # Get images
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"      # Get container IP
alias dkd="docker run -P -d"                                                # Run deamonized container, e.g., $dkd base /bin/echo hello
alias dki="docker run -P -it"                                               # Run interactive container, e.g., $dki base /bin/bash
alias dkr="dki --rm"                                                        # Run interactive container and remove afterwards
alias dl="docker ps -l -q"                                                  # Get latest container ID
alias dpa="docker ps -a"                                                    # Get process included stop container
alias dps="docker ps"                                                       # Get container process
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)' # Stop and Remove all containers
alias dv="docker volume"
alias elastic-clean="curl -XPUT -H \"Content-Type: application/json\" http://localhost:9200/_cluster/settings -d '{ \"transient\": { \"cluster.routing.allocation.disk.threshold_enabled\": false } }' && curl -XPUT -H \"Content-Type: application/json\" http://localhost:9200/_all/_settings -d '{\"index.blocks.read_only_allow_delete\": null}'"
alias ghcr.login="echo ${CR_PAT} | docker login ghcr.io -u petemcw --password-stdin"

# MacOS
# similar to top
alias top='htop'

# pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_ed25519.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# update lookup database
alias updatedb="sudo /usr/libexec/locate.updatedb"

# flush local DNS cache
alias flush-dns="sudo killall -9 mDNSResponder && sudo killall -9 dnsmasq"

# kill preferences system
alias flush-prefs="killall cfprefsd"

# Brew
alias bsl="brew services list"
alias bsp="brew services stop"
alias bst="brew services start"
