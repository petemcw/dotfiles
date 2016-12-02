#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Dock"

execute "defaults write com.apple.dock autohide -bool true" \
  "Automatically hide the Dock"

execute "defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true" \
  "Enable spring loading for all Dock items"

execute "defaults write com.apple.dock expose-group-by-app -bool false" \
  "Do not group windows by application in Mission Control"

execute "defaults write com.apple.dock mineffect -string 'scale'" \
  "Change minimize/maximize window effect"

execute "defaults write com.apple.dock minimize-to-application -bool true" \
  "Reduce clutter by minimizing windows into their application icons"

execute "defaults write com.apple.dock mru-spaces -bool false" \
  "Do not automatically rearrange spaces based on most recent use"

execute "defaults write com.apple.dock persistent-apps -array && defaults write com.apple.dock persistent-others -array " \
  "Wipe all app icons"

execute "defaults write com.apple.dock show-process-indicators -bool true" \
  "Show indicator lights for open applications"

execute "defaults write com.apple.dock showhidden -bool true" \
  "Make icons of hidden applications translucent"

execute "defaults write com.apple.dock tilesize -int 36" \
  "Set icon size"

execute "defaults write com.apple.Dock autohide-delay -float 0" \
  "Remove the auto-hiding Dock delay"

execute "defaults write com.apple.dock orientation -string 'left'" \
  "Move Dock to left side of the screen"

execute "defaults write com.apple.dock launchanim -bool false" \
  "Don’t animate opening applications from the Dock"

execute "defaults write com.apple.dock expose-animation-duration -float 0.1" \
  "Speed up Mission Control animations"

execute "defaults write com.apple.dock persistent-others -array-add '<dict>
    <key>tile-data</key>
    <dict>
      <key>file-data</key>
      <dict>
        <key>_CFURLString</key>
        <string>file:///Applications/</string>
        <key>_CFURLStringType</key>
        <integer>15</integer>
      </dict>
      <key>displayas</key>
      <integer>1</integer>
      <key>file-type</key>
      <integer>2</integer>
      <key>file-label</key>
      <string>Applications</string>
      <key>preferreditemsize</key>
      <integer>-1</integer>
      <key>showas</key>
      <integer>3</integer>
    </dict>
      <key>tile-type</key>
      <string>directory-tile</string>
  </dict>'" \
  "Add applications to the dock"

# Dock is the parent process of Dashboard
killall "Dock" &>/dev/null
