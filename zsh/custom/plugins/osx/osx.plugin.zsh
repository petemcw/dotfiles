function quick-look() {
  (( $# > 0 )) && qlmanage -p $* &>/dev/null &
}

function man-preview() {
  man -t "$@" | open -f -a Preview
}

# Pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# GRC colorizes nifty unix tools all over the place
if $(grc &>/dev/null)
then
  source `brew --prefix`/etc/grc.bashrc
fi

# Redis
alias redis-up='redis-server $DOTS/redis/redis.conf > /dev/null &'
alias redis-down='killall redis-server'

# Fix Mac OS X delete key issue
bindkey "^[[3~" delete-char

# Alias for common Linux utility
alias updatedb='sudo /usr/libexec/locate.updatedb'

# Flush the local DNS cache
alias flushdns='sudo dscacheutil -flushcache'

# Boot the system in full 64-bit mode
alias boot64='sudo systemsetup -setkernelbootarchitecture x86_64'

# Restart Finder.app
alias finder:restart='sudo killall Finder && sudo pen /System/Library/CoreServices/Finder.app'

# Desktop Programs
alias preview="open -a '$PREVIEW'"
alias safari="open -a safari"
alias firefox="open -a firefox"
alias chrome="open -a google\ chrome"
alias finder='open -a Finder '
