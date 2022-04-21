#!/usr/bin/env bash
################################################################################
#
# Defines methods for use in Brew package installation.
#
################################################################################

# -------------------------------------------------------------------------------
# Install common Homebrew packges.
# -------------------------------------------------------------------------------
dots_configure_brews() {
    if [[ "${DOTS_OS}" == "darwin" ]]; then
        dots_brew_install "coreutils"
        dots_brew_install "findutils"
        dots_brew_install "htop-osx"
        dots_brew_install "ssh-copy-id"
        dots_brew_install "moreutils"
    fi

    if [[ "${DOTS_OS}" == "linux" ]]; then
        dots_brew_install "apt-utils"
        dots_brew_install "apt-transport-https"
        dots_brew_install "build-essential"
        dots_brew_install "lynx"
        dots_brew_install "software-properties-common"
    fi

    dots_brew_install "ack"
    dots_brew_install "ca-certificates"
    dots_brew_install "cloudflared"
    dots_brew_install "curl"
    dots_brew_install "ffmpeg"
    dots_brew_install "fzf"
    dots_brew_install "gnu-sed"
    dots_brew_install "gnu-tar"
    dots_brew_install "grc"
    dots_brew_install "openssl"
    dots_brew_install "p7zip"
    dots_brew_install "pandoc"
    dots_brew_install "python"
    dots_brew_install "romkatv/powerlevel10k/powerlevel10k"
    dots_brew_install "tmux"
    dots_brew_install "tree"
    dots_brew_install "vim"
    dots_brew_install "wget"
    dots_brew_install "yt-dlp"
    dots_brew_install "z"
    dots_brew_install "zsh-autosuggestions"
    dots_brew_install "zsh-completions"
    dots_brew_install "zsh-syntax-highlighting"
    dots_brew_install "zsh"

    dots_ask_bool "Do you want to install development brews?"
    if [[ -z "${dots_continue}" ]]; then
        dots_erase_lines 1
        dots_check "Skipping development brews"
        dots_start_spinner
        dots_stop_spinner 0
    else
        dots_erase_lines 1
        dots_brew_install "git-flow"
        dots_brew_install "git"
        dots_brew_install "go"
        dots_brew_install "jq"
        dots_brew_install "mcrypt"
        dots_brew_install "mysql-client"
        dots_brew_install "nghttp2"
        dots_brew_install "nginx"
        dots_brew_install "php"
        dots_brew_install "php@7.4"
        dots_brew_install "php-code-sniffer"
        dots_brew_install "php-cs-fixer"
        dots_brew_install "shellcheck"
        dots_brew_install "shfmt"
    fi
}

# -------------------------------------------------------------------------------
# Install Homebrew packge.
#
# Arguments:
#   $1 (required) - The name of the package to install.
# -------------------------------------------------------------------------------
dots_brew_install() {
    local formula_name="${1}"

    if ! hash "brew" 2>/dev/null; then
        dots_command_fail "The brew binary was not found."
    fi

    if brew list "${formula_name}" &>/dev/null; then
        dots_check "Skipping '$(dots_notice "${formula_name}" true)'"
        dots_start_spinner
        dots_stop_spinner 0
    else
        dots_check "Installing brew for '$(dots_notice "${formula_name}" true)'"
        dots_start_spinner
        if ! brew install "${formula_name}" &>/dev/null; then
            dots_stop_spinner 1
        else
            dots_stop_spinner 0
        fi
    fi
}
