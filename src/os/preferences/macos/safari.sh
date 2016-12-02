#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Safari"

execute "defaults write com.apple.Safari AutoOpenSafeDownloads -bool false" \
  "Disable opening 'safe' files automatically"

execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true" \
  "Set backspace key to go to the previous page in history"

execute "defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true \
      && defaults write com.apple.Safari IncludeDevelopMenu -bool true \
      && defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true" \
  "Enable the 'Develop' menu and the 'Web Inspector'"

execute "defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false" \
  "Set search type to 'Contains' instead of 'Starts With'"

execute "defaults write com.apple.Safari HomePage -string 'https://www.google.com'" \
  "Set home page to Google"

execute "defaults write com.apple.Safari IncludeInternalDebugMenu -bool true" \
  "Enable 'Debug' menu"

execute "defaults write com.apple.Safari ShowFavoritesBar -bool false" \
  "Hide bookmarks bar by default"

execute "defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true" \
  "Show the full URL in the address bar"

execute "defaults write com.apple.Safari SuppressSearchSuggestions -bool true \
      && defaults write com.apple.Safari UniversalSearchEnabled -bool false" \
  "Don’t send search queries to Apple"

execute "defaults write -g WebKitDeveloperExtras -bool true" \
  "Add a context menu item for showing the 'Web Inspector' in web views"

execute "defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true \
      && defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true" \
  "Tab to highlight each item on a web page"

execute "defaults write com.apple.Safari ShowSidebarInTopSites -bool false" \
  "Hide Safari’s sidebar in Top Sites"

execute "defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2" \
  "Disable Safari’s thumbnail cache for History and Top Sites"

execute "defaults write com.apple.Safari ProxiesInBookmarksBar '()'" \
  "Remove useless icons from Safari’s bookmarks bar"

killall "Safari" &>/dev/null
