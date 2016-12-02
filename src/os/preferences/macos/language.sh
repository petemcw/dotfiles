#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Language & Region"

execute "defaults write -g AppleLanguages -array 'en'" \
  "Set language"

execute "defaults write -g AppleLocale -string 'en_US@currency=USD'" \
  "Set locale"

execute "defaults write -g AppleMeasurementUnits -string 'Inches' \
      && defaults write NSGlobalDomain AppleMetricUnits -bool false" \
  "Set measurement units"

execute "sudo systemsetup -settimezone 'America/Chicago' > /dev/null" \
  "Set the timezone"
