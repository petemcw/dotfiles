#!/usr/bin/env zsh

# similar to top
alias top='htop'

# pipe my public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"

# update lookup database
alias updatedb="sudo /usr/libexec/locate.updatedb"

# flush local DNS cache
alias flush-dns="sudo killall -9 mDNSResponder && sudo killall -9 dnsmasq"

# kill preferences system
alias flush-prefs="killall cfprefsd"

# show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
