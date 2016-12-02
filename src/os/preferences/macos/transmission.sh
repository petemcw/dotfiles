#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Transmission"

execute "defaults write org.m0k.transmission DeleteOriginalTorrent -bool true" \
  "Delete the original torrent files"

execute "defaults write org.m0k.transmission DownloadAsk -bool false" \
  "Don’t prompt for confirmation before downloading"

execute "defaults write org.m0k.transmission MagnetOpenAsk -bool false" \
  "Don’t prompt for confirmation before downloading for magnet links"

execute "defaults write org.m0k.transmission DownloadChoice -string 'Constant' \
      && defaults write org.m0k.transmission DownloadFolder -string '$HOME/Downloads'" \
  "Use '~/Downloads' to store complete downloads"

execute "defaults write org.m0k.transmission UseIncompleteDownloadFolder -bool true \
      && defaults write org.m0k.transmission IncompleteDownloadFolder -string '$HOME/Downloads/torrents'" \
  "Use '~/Public/torrents' to store incomplete downloads"

execute "defaults write org.m0k.transmission WarningDonate -bool false" \
  "Hide the donate message"

execute "defaults write org.m0k.transmission WarningLegal -bool false" \
  "Hide the legal disclaimer"

killall "Transmission" &>/dev/null
