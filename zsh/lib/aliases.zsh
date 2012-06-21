# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Reload ZSH config
alias reload!='source ~/.zshrc'

# Super user
alias _='sudo'

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

# Development tools
alias opendig="dig @208.67.222.222"
alias phpcs='phpcs --standard=zend'
alias sniff='find . -type f -iname "*.php" -print0 |xargs phpcs --standard=zend'
alias mfavicon='convert -colors 256 -resize 16x16 '
