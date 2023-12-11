#!/usr/bin/env bash
################################################################################
#
# Installation script for the dotfiles.
#
################################################################################

set -euo pipefail
IFS=$'\n\t'

# -------------------------------------------------------------------------------
# Defines read-only script variables.
# -------------------------------------------------------------------------------
readonly DOTS_BRANCH="${DOTS_BRANCH:-master}"
readonly DOTS_OS="$(uname -s | awk '{print tolower($0)}')"
readonly DOTS_PATH="${DOTS_PATH:-$HOME/.dotfiles}"
readonly DOTS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTS_SSHKEY="${DOTS_SSHKEY:-id_ed25519}"
readonly DOTS_URI="${DOTS_URI:-https://github.com/petemcw/dotfiles.git}"

# -------------------------------------------------------------------------------
# Sets flags which can be overridden by user input.
# Default values are below.
# -------------------------------------------------------------------------------
declare DEBUG=false
declare -a ARGS=()

# -------------------------------------------------------------------------------
# Create a temp directory with three random numbers and the process ID
# in the name. This directory is removed automatically at exit.
# -------------------------------------------------------------------------------
readonly DOTS_TMP_PATH="$(mktemp -d -t tmp.XXXXXXXXXX)"

# -------------------------------------------------------------------------------
# Sources script helper files.
# -------------------------------------------------------------------------------
_import_funcs() {
    local source_file="${DOTS_SCRIPT_PATH}/helpers/functions.sh"
    if [[ -f "${source_file}" ]]; then
        # shellcheck source=/dev/null
        . "${source_file}"
    else
        _download_funcs || exit 1
    fi
}
_download_funcs() {
    local source_file="${DOTS_TMP_PATH}/functions.sh"
    curl -LsSo "${source_file}" "https://raw.githubusercontent.com/petemcw/dotfiles/${DOTS_BRANCH}/helpers/functions.sh"
    # shellcheck source=/dev/null
    . "${source_file}" &&
        rm -Rf "${source_file}" &&
        return 0
    return 1
}
_import_funcs

# -------------------------------------------------------------------------------
# Program Usage
# -------------------------------------------------------------------------------
dots_usage() {
    printf "\n"
    printf "%b\n" "${COLOR_BOLD}Usage:${COLOR_RESET}"
    printf "  %s [options...]\n" "dotties"
    printf "\n"
    printf "%b\n" "${COLOR_BOLD}Options:${COLOR_RESET}"
    printf "  -d, --debug             Runs script in BASH debug mode\n"
    printf "  -h, --help              Display this help and exit\n"
}

# -------------------------------------------------------------------------------
# Parse Program Options
# -------------------------------------------------------------------------------
dots_options() {
    local options=()
    local opt_string=h

    # normalize options
    # breaking -ab into -a -b when needed and --foo=bar into --foo bar
    while (("$#")); do
        case "${1}" in
        # if option is of type -ab
        -[!-]?*)
            # loop over each character starting with the second
            for ((i = 1; i < "${#1}"; i++)); do
                c="${1:i:1}"
                options+=("-${c}") # add current char to options
                # if option takes a required argument, and it's not the last char make
                # the rest of the string its argument
                if [[ "${opt_string}" == *"${c}:"* && "${1:i+1}" ]]; then
                    options+=("${1:i+1}")
                    break
                fi
            done
            ;;
        # if option is of type --foo=bar
        --?*=*)
            options+=("${1%%=*}" "${1#*=}")
            ;;
        # add --endopts for --
        --)
            options+=(--endopts)
            ;;
        # otherwise, nothing special
        *)
            options+=("${1}")
            ;;
        esac
        shift
    done
    if [[ "${#options[@]}" -ne 0 ]]; then
        set -- "${options[@]}"
    fi
    unset options

    # handle positional arguments
    while [[ "${1:-}" == -?* ]]; do
        case "${1}" in
        -h | --help)
            dots_usage >&2
            dots_exit
            ;;
        -d | --debug)
            DEBUG=true
            ;;
        --endopts)
            shift
            break
            ;;
        *)
            dots_error "dotties: invalid option '${1}'"
            dots_fatal "dotties: try 'dotties --help' for more information."
            ;;
        esac
        shift
    done

    # store the remaining user input as arguments
    ARGS+=("$@")
}

# -------------------------------------------------------------------------------
# Main Program
# -------------------------------------------------------------------------------
dots_run() {
    dots_ask_bool "Install dotties to your system?"
    if [[ -z "${dots_continue:-}" ]]; then
        dots_exit
    else
        # reset output
        dots_erase_lines 2
    fi

    dots_dependencies
    dots_ask_sudo
    dots_clone

    _import_helpers

    dots_header "Installing the CLI goodies"
    dots_create_dirs
    dots_enable_paths "copy"
    dots_enable_paths "symlink"

    dots_header "Configuring your system"
    dots_copy_assets
    dots_generate_keys
    dots_configure_git
    dots_configure_xcode
    dots_configure_homebrew
    dots_configure_brews
    dots_configure_vim
    dots_configure_zsh

    dots_success "\ndotties has been installed successfully!\n"
}

################################################################################
#
# RUN THE SCRIPT
# Nothing should be edited below this block.
#
################################################################################

# trap exits with your cleanup function
trap dots_fail SIGINT SIGQUIT
trap dots_exit INT TERM EXIT

# parse arguments passed to script
dots_options "$@"

# run in debug mode, if set
[[ "${DEBUG}" == "true" ]] && set -x

# main script run
dots_run

# clean exit
dots_exit
