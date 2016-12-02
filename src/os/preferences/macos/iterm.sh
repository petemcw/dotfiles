#!/bin/bash

# shellcheck source=/dev/null
cd "$DOTFILES_PATH" \
  && source "$DOTFILES_PATH/src/os/helpers.sh"

#------------------------------------------------------------------------------#

printf "\n"
print_title "iTerm"

execute "/usr/libexec/PlistBuddy ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Create preference file is it doesn't exist"

execute "/usr/libexec/PlistBuddy -c \"Add :'New Bookmarks' dict\" ~/Library/Preferences/com.googlecode.iterm2.plist \
      && /usr/libexec/PlistBuddy -c \"Add :'New Bookmarks':0 array\" ~/Library/Preferences/com.googlecode.iterm2.plist " \
  "Create profile array"

execute "defaults write com.googlecode.iterm2 PromptOnQuit -bool false" \
  "Don’t display the annoying prompt when quitting iTerm"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Terminal Type\" xterm-256color' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set terminal emulation to xterm-256color"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Unlimited Scrollback\" true' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Enable unlimted scrollback"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Blinking Cursor\" true' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set cursor to blink"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Cursor Type\" 0' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set cursor type to underline"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Blur\" true' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Enable background blur"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Blur Radius\" 2.000000' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set background blur level"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Transparency\" 0.072000' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set transparency level"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Normal Font\" InconsolataForPowerline 18' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set normal font"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Non Ascii Font\" DejaVuSansMonoForPowerline 14' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set non-ascii font"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Columns\" 130' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set initial column size"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Rows\" 34' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Set initial row size"

execute "/usr/libexec/PlistBuddy -c 'Set :\"New Bookmarks\":0:\"Use Bold Font\" false' ~/Library/Preferences/com.googlecode.iterm2.plist" \
  "Do not use bold font"

killall "iTerm2" &>/dev/null
