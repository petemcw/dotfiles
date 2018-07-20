#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "UX/UI preferences"

execute "sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string 'Arbor' \
      && sudo scutil --set ComputerName 'Banff' \
      && sudo scutil --set HostName 'Banff' \
      && sudo scutil --set LocalHostName 'Banff'" \
  "Set computer name"

execute "sudo defaults write /Library/Preferences/com.apple.loginwindow LoginwindowText 'Property of Peter McWilliams. Contact 612-203-1226 if found.'" \
  "Login Screen Note"

execute "defaults write com.apple.menuextra.battery ShowPercent -string 'NO'" \
  "Hide battery percentage from the menu bar"

execute "defaults write com.apple.CrashReporter UseUNC 1" \
  "Make crash reports appear as notifications"

execute "defaults write com.apple.LaunchServices LSQuarantine -bool false" \
  "Disable 'Are you sure you want to open this application?' dialog"

execute "defaults write com.apple.print.PrintingPrefs 'Quit When Finished' -bool true" \
  "Automatically quit the printer app once the print jobs are completed"

execute "defaults write com.apple.screencapture disable-shadow -bool true" \
  "Disable shadow in screenshots"

execute "defaults write com.apple.screencapture location -string '$HOME/Desktop'" \
  "Save screenshots to the Desktop"

execute "defaults write com.apple.screencapture type -string 'png'" \
  "Save screenshots as PNGs"

execute "defaults write com.apple.screensaver askForPassword -int 1 \
      && defaults write com.apple.screensaver askForPasswordDelay -int 0"\
  "Require password immediately after into sleep or screen saver mode"

execute "defaults write -g AppleFontSmoothing -int 2" \
  "Enable subpixel font rendering on non-Apple LCDs"

execute "sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true" \
  "Enable HiDPI display modes (requires restart)"

execute "defaults write -g AppleShowScrollBars -string 'Always'" \
  "Always show scrollbars"

execute "defaults write -g NSDisableAutomaticTermination -bool true" \
  "Disable automatic termination of inactive apps"

execute "defaults write -g NSNavPanelExpandedStateForSaveMode -bool true" \
  "Expand save panel by default"

execute "defaults write -g NSTableViewDefaultSizeMode -int 2" \
  "Set sidebar icon size to medium"

execute "defaults write -g NSUseAnimatedFocusRing -bool false" \
  "Disable the over-the-top focus ring animation"

execute "defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false" \
  "Disable resume system-wide"

execute "defaults write -g PMPrintingExpandedStateForPrint -bool true" \
  "Expand print panel by default"

execute "sudo systemsetup -setrestartfreeze on" \
  "Restart automatically if the computer freezes"

execute "sudo pmset -a standbydelay 86400" \
  "Standby delay set to 24 hours"

execute "defaults write NSGlobalDomain NSWindowResizeTime -float 0.001" \
  "Increase window resize speed for Cocoa applications"

execute "sudo systemsetup -setcomputersleep Off &> /dev/null" \
  "Never go into computer sleep mode"

execute "defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false \
      && defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add 'automaticQuoteSubstitutionEnabled' -bool false" \
  "Disable smart quotes"

execute "defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false" \
  "Disable smart dashes"

execute "defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true" \
  "Display ASCII control characters using caret notation"

execute "defaults write com.apple.helpviewer DevMode -bool true" \
  "Set Help Viewer windows to non-floating mode"

execute "defaults write NSGlobalDomain AppleHighlightColor -string '1.000000 0.749020 0.823529'" \
  "Set highlight color to red"

execute "defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true" \
  "Prevent Time Machine from prompting to use new hard drives as backup volume"

# Dock is the parent process of Dashboard
killall "SystemUIServer" &>/dev/null
