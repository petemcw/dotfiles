#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Maps"

execute "defaults write com.apple.Maps LastClosedWindowViewOptions '{
           localizeLabels = 1;   // show labels in English
           mapType = 11;         // show hybrid map
           trafficEnabled = 0;   // do not show traffic
         }'" \
  "Set view options"

killall "Maps" &>/dev/null
