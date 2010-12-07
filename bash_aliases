#
# Navigation
#
alias ..='cd ..'
alias ...='cd ..; cd ..;'
alias ls="ls -F $LS_COLOR_OPTIONS"
alias ll="ls -lhF $LS_COLOR_OPTIONS"
alias l="ls -alhF $LS_COLOR_OPTIONS"

#
# Search
#
alias grep='grep --color -i'
alias g='grep'
# Case-insensitive, exclude .svn folders
greps(){
  find . -path '*/.svn' -prune -o -type f -print0 | xargs -0 grep -I -n -e "$1"
}
alias f='find'

#
# Misc. System Aliases
#
alias vi='vim'
alias v='vim'
alias checkhistory='history |grep'
alias ch='history |grep'
alias diff='diff -ubB'
alias untar='tar -zxvf'
alias systail='tail -f /var/log/system.log'
alias cp_folder='cp -Rpv'
alias bashreload='. ~/.bashrc'
# Shows most used commands
# http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"
alias findport80="netstat -tunpl | awk '/:80/ {print $7}' | cut -d'/' -f 1"
alias psapache='ps -ylC httpd --sort:rss'
alias mysqldump='mysqldump --opt -Q --order-by-primary'

# Human-readable filesizes
alias du='du -h'
alias df='df -h'
alias ducks='du -cksh * |sort -rn |head -11'
alias free='free -m'

# Ask before clobbering a file
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Miscellaneous
alias cd..='cd ..' # fix a common typo
alias fixpermd='find . -type d -exec chmod 755 {} \;'
alias fixpermf='find . -type f -exec chmod 644 {} \;'
alias nsopen='netstat -lptu' # <-- list open Internet facing ports

# Development tools
alias opendig="dig @208.67.222.222"
alias svnaddall='svn status | grep "^\?" | awk "{print \$2}" | xargs svn add'
alias svndeletesvnfolders='find . -name ".svn" -exec rm -rf {} \;'
alias svndeleteall='svn status | grep "^\!" | awk "{print \$2}" | xargs svn delete'
alias svndiff='svn diff --diff-cmd fmdiff'
