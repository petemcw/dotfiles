#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Activity Monitor"

execute "defaults write com.apple.ActivityMonitor OpenMainWindow -bool true" \
  "Show the main window when launching Activity Monitor"

execute "defaults write com.apple.ActivityMonitor IconType -int 5" \
  "Visualize CPU usage in the Activity Monitor dock icon"

execute "defaults write com.apple.ActivityMonitor ShowCategory -int 0" \
  "Show all processes in Activity Monitor"

execute "defaults write com.apple.ActivityMonitor SortColumn -string 'CPUUsage' \
      && defaults write com.apple.ActivityMonitor SortDirection -int 0" \
  "Sort Activity Monitor results by CPU usage"

killall "Activity Monitor" &>/dev/null
