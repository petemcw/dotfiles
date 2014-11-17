#
# OS X aliases
#

# update lookup database
alias updatedb="sudo /usr/libexec/locate.updatedb"

# flush local DNS cache
alias flush="dscacheutil -flushcache"

# clean up LaunchServices to remove duplicates in the "Open With" menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# redis
alias redis.start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist"
alias redis.stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist"

# dns
alias dns.start="sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist"
alias dns.stop="sudo launchctl unload -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist"

# nginx
alias nginx.start="sudo launchctl load -w /Library/LaunchAgents/homebrew.mxcl.nginx.plist"
alias nginx.stop="sudo launchctl unload -w /Library/LaunchAgents/homebrew.mxcl.nginx.plist"
alias nginx.reload="/usr/local/bin/nginx -s reload"
alias vhosts="cd /usr/local/etc/nginx/sites-enabled"

# php
alias php.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist"
alias php.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist"

# percona
alias percona.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.percona-server.plist"
alias percona.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.percona-server.plist"

# mongodb
alias mongo.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
alias mongo.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
