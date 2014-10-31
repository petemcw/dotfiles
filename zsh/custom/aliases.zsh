#
# Common aliases
#

# add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# reload ZSH config
alias reload!='source ~/.zshrc'

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# misc. system aliases
alias ssh='ssh -o ServerAliveInterval=60'
alias diff='diff -ubB'
alias untar='tar -zxvf'
alias zipcreate='zip -y -r -q'
alias cp_folder='cp -Rpv'
alias fixpermd='find . -type d -exec chmod 755 {} \;'
alias fixpermf='find . -type f -exec chmod 644 {} \;'
alias nsopen='netstat -lptu'
alias grep="grep -i $GREP_OPTIONS"
alias history='history 1'
alias ios="open /Applications/Xcode.app/Contents/Applications/iOS\ Simulator.app"

# directory listing
alias l='ls -lAh'        # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias sl='ls'            # I often screw this up.

# file download
if (( $+commands[curl] )); then
  alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
elif (( $+commands[wget] )); then
  alias get='wget --continue --progress=bar --timestamping'
fi

# resource usage
alias df='df -kh'
alias du='du -kh'
alias free='free -m'

if (( $+commands[htop] )); then
  alias top='htop'
else
  alias topc='top -o cpu'
  alias topm='top -o vsize'
fi
