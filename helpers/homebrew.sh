#!/usr/bin/env bash
################################################################################
#
# Defines methods for installing Homebrew.
#
################################################################################

# -------------------------------------------------------------------------------
# Configure Homebrew.
# -------------------------------------------------------------------------------
dots_configure_homebrew() {
    dots_check "Installing Homebrew"
    dots_start_spinner
    if ! NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>/dev/null; then
        dots_command_fail "Failed to install Homebrew!"
    fi
    dots_stop_spinner 0

    dots_check "Opting out of Homebrew analytics"
    dots_start_spinner
    if ! brew analytics off &>/dev/null; then
        dots_command_fail "Failed to opt out of Homebrew analytics!"
    fi
    dots_stop_spinner 0

    dots_check "Updating Homebrew repository"
    dots_start_spinner
    if ! brew update &>/dev/null; then
        dots_command_fail "Failed to update Homebrew!"
    fi
    dots_stop_spinner 0
}
