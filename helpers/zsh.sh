#!/usr/bin/env bash
################################################################################
#
# Defines methods for installing Zsh.
#
################################################################################

# -------------------------------------------------------------------------------
# Configure default shell.
# -------------------------------------------------------------------------------
dots_configure_zsh() {
    local desired_shell=""
    desired_shell=$(which zsh)

    # dots_check "Adding '$(dots_warning "${desired_shell}" true)' as a valid login shell"
    # dots_start_spinner
    # if ! grep -Fq "${desired_shell}" /etc/shells &&
    #     echo "${desired_shell}" | sudo tee -a /etc/shells &>/dev/null; then
    #     dots_command_fail "Failed to configure valid shells!"
    # fi
    # dots_stop_spinner 0

    dots_check "Setting '$(dots_warning "${desired_shell}" true)' as default login shell"
    dots_start_spinner
    if ! sudo chsh -s "${desired_shell}" "$(whoami)" &>/dev/null; then
        dots_command_fail "Failed to configure login shell!"
    fi
    dots_stop_spinner 0
}
