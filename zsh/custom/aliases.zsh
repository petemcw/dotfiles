# Don't expand aliases _before_ completion has finished
#   like: git comm-[tab]
setopt COMPLETE_ALIASES

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Reload ZSH config
alias reload!='source ~/.zshrc'

# Filesystem aliases
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias cd...='cd ../..'
alias cd....='cd ../../..'
alias cd.....='cd ../../../..'
alias cd/='cd /'
alias md='mkdir -p'
alias rd='rmdir'
alias d='dirs -v | head -10'

# List directory contents
alias l='ls -lah'
alias ll='ls -lFh'
alias la='ls -AF'
alias lld='ls -l | grep ^d'
alias sl='ls' # fix common typo

# Ask before clobbering a file
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias rmf='rm -rf'

# History
alias history='fc -l 1'

# Helpers
alias grep='grep --color=auto'
alias df='df -h' # disk free, in Gigabytes, not bytes
alias du='du -h -c' # calculate disk usage for a folder
alias diff='diff -ubB'
alias untar='tar -zxvf'
alias zipcreate='zip -y -r -q'
alias cp_folder='cp -Rpv'
alias ssh='ssh -4g -o ServerAliveInterval=60'
# Remove the hosts that I don't want to keep around- in this case, only
# keep the first host. Like a boss.
alias hosts="head -2 ~/.ssh/known_hosts | tail -1 > ~/.ssh/known_hosts"
alias fixpermd='find . -type d -exec chmod 755 {} \;'
alias fixpermf='find . -type f -exec chmod 644 {} \;'

# Development tools
alias opendig="dig @208.67.222.222"
alias phpcs='phpcs --standard=zend'
alias sniff='find . -type f -iname "*.php" -print0 |xargs phpcs --standard=zend'
alias mfavicon='convert -colors 256 -resize 16x16 '

# RESTful
alias cget='curl -i -X GET -H "Accept: application/json"'
alias cput='curl -i -X PUT -H "Accept: application/json"'
alias cpost='curl -i -X POST -H "Accept: application/json"'
alias cdel='curl -i -X DELETE -H "Accept: application/json"'

# Apache
alias apache.up="sudo service apache2 start"
alias apache.down="sudo service apache2 stop"
alias apache.check="sudo service apache2 configtest"
alias apache!="sudo service apache2 reload"
alias httpd.up="sudo /etc/init.d/httpd start"
alias httpd.down="sudo /etc/init.d/httpd stop"
alias httpd.check="sudo /etc/init.d/httpd configtest"
alias httpd!="sudo /etc/init.d/httpd reload"

# Nginx
alias nginx.up="sudo /etc/init.d/nginx start"
alias nginx.down="sudo /etc/init.d/nginx stop"
alias nginx.check="sudo /etc/init.d/nginx configtest"
alias nginx!="sudo /etc/init.d/nginx reload"

# PHP-FPM
alias php.up="sudo /etc/init.d/php-fpm start"
alias php.down="sudo /etc/init.d/php-fpm stop"
alias php.check="sudo /etc/init.d/php-fpm configtest"
alias php!="sudo /etc/init.d/php-fpm reload"

# PostgreSQL
alias pg.up='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg.down='pg_ctl -D /usr/local/var/postgres stop -s -m fast'
