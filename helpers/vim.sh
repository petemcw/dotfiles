#!/usr/bin/env bash
################################################################################
#
# Defines methods for installing Vim.
#
################################################################################

# -------------------------------------------------------------------------------
# Configure Vim editor.
# -------------------------------------------------------------------------------
dots_configure_vim() {
    local plugin_path="${HOME}/.vim/autoload/plug.vim"
    local plugin_url="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    if [ ! -f "${plugin_path}" ]; then
        dots_check "Installing Vim plug-in manager"
        dots_start_spinner
        if ! curl -fLo "${plugin_path}" --create-dirs "${plugin_url}" &>/dev/null; then
            dots_stop_spinner 1
        else
            dots_stop_spinner 0
        fi
    else
        dots_check "Updating Vim plug-ins"
        dots_start_spinner
        if ! vim +PlugUpdate +qall &>/dev/null; then
            dots_stop_spinner 1
        else
            dots_stop_spinner 0
        fi
    fi
}
