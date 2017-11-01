#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "Finder"

execute "defaults write com.apple.finder _FXShowPosixPathInTitle -bool true" \
  "Use full POSIX path as window title"

execute "defaults write com.apple.finder DisableAllAnimations -bool true" \
  "Disable all animations"

execute "defaults write com.apple.finder FXDefaultSearchScope -string 'SCcf'" \
  "Search the current directory by default"

execute "defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false" \
  "Disable warning when changing a file extension"

# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
execute "defaults write com.apple.finder FXPreferredViewStyle -string 'clmv'" \
  "Use column view in all Finder windows by default"

# Set Home as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
execute "defaults write com.apple.finder NewWindowTarget -string 'PfHm' \
      && defaults write com.apple.finder NewWindowTargetPath -string 'file://$HOME/'" \
  "Set 'Home' as the default location for new Finder windows"

execute "defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true \
      && defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true \
      && defaults write com.apple.finder ShowMountedServersOnDesktop -bool true \
      && defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true" \
  "Show icons for hard drives, servers, and removable media on the desktop"

execute "defaults write com.apple.finder ShowRecentTags -bool false" \
  "Do not show recent tags"

execute "defaults write -g AppleShowAllExtensions -bool true" \
  "Show all filename extensions"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:iconSize 84' ~/Library/Preferences/com.apple.finder.plist \
      && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:iconSize 84' ~/Library/Preferences/com.apple.finder.plist" \
  "Set icon size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:gridSpacing 24' ~/Library/Preferences/com.apple.finder.plist \
      && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:gridSpacing 24' ~/Library/Preferences/com.apple.finder.plist" \
  "Set icon grid spacing size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:textSize 13' ~/Library/Preferences/com.apple.finder.plist \
      && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:textSize 13' ~/Library/Preferences/com.apple.finder.plist" \
  "Set icon label text size"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist \
      && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:labelOnBottom true' ~/Library/Preferences/com.apple.finder.plist" \
  "Set icon label position"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist \
      && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:showItemInfo true' ~/Library/Preferences/com.apple.finder.plist" \
  "Show item info"

execute "/usr/libexec/PlistBuddy -c 'Set :DesktopViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist \
      && /usr/libexec/PlistBuddy -c 'Set :StandardViewSettings:IconViewSettings:arrangeBy none' ~/Library/Preferences/com.apple.finder.plist" \
  "Set sort method"

execute "defaults write com.apple.finder ShowStatusBar -bool true" \
  "Show status bar"

execute "defaults write com.apple.finder ShowPathbar -bool true" \
  "Show path bar"

execute "defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true" \
  "Avoid creating .DS_Store files on network volumes"

execute "defaults write com.apple.frameworks.diskimages skip-verify -bool true \
      && defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true \
      && defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true" \
  "Disable disk image verification"

execute "defaults write com.apple.finder EmptyTrashSecurely -bool false" \
  "Disable empty Trash securely by default"

execute "defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true" \
  "Enable AirDrop over Ethernet"

execute "defaults write com.apple.finder QLEnableTextSelection -bool true" \
  "Allow text selection in Quick Look"

execute "defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false" \
  "Save to disk (not to iCloud) by default"

killall "Finder" &>/dev/null

# Starting with Mac OS X Mavericks preferences are cached,
# so in order for things to get properly set using `PlistBuddy`,
# the `cfprefsd` process also needs to be killed.
killall "cfprefsd" &>/dev/null
