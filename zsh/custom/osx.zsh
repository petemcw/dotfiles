#
# OS X aliases
#

# update lookup database
alias updatedb="sudo /usr/libexec/locate.updatedb"

# flush local DNS cache
# alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias flush="dscacheutil -flushcache"

# clean up LaunchServices to remove duplicates in the “Open With” menu
alias lscleanup="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

# show/hide hidden files in Finder
alias show="defaults write com.apple.Finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.Finder AppleShowAllFiles -bool false && killall Finder"

# hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# redis
#alias redis-up="redis-server /usr/local/etc/redis.conf"
alias redis-up="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.redis.plist"
alias redis-down="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.redis.plist"

# dns
alias dns-up="sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist"
alias dns-down="sudo launchctl unload -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist"

# nginx
alias nginx-up="sudo launchctl load -w /Library/LaunchAgents/homebrew.mxcl.nginx.plist"
alias nginx-down="sudo launchctl unload -w /Library/LaunchAgents/homebrew.mxcl.nginx.plist"
alias nginx-reload="/usr/local/bin/nginx -s reload"
alias vhosts="cd /usr/local/etc/nginx/sites-enabled"

# php
alias php-up="launchctl load -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php54.plist"
alias php-down="launchctl unload -w ~/Library/LaunchAgents/homebrew-php.josegonzalez.php54.plist"

# percona
alias percona-up="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.percona-server.plist"
alias percona-down="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.percona-server.plist"

# postgresapp.com
alias psql="/Applications/Postgres93.app/Contents/MacOS/bin/psql"

# mongodb
alias mongo-up="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
alias mongo-down="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
