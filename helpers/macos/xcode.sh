#!/usr/bin/env bash
################################################################################
#
# Defines methods for installing Xcode.
#
################################################################################

# -------------------------------------------------------------------------------
# Install command-line tools.
# -------------------------------------------------------------------------------
dots_configure_xcode() {
    if [[ "${DOTS_OS}" == "darwin" ]]; then
        dots_check "Installing Xcode Command Line Tools"
        dots_start_spinner
        if ! /usr/bin/xcode-select -print-path &>/dev/null; then
            /usr/bin/xcode-select --install &>/dev/null
            until /usr/bin/xcode-select -print-path &>/dev/null; do
                sleep 5
            done
        fi
        dots_stop_spinner 0
    fi
}
