#!/usr/bin/env bash
################################################################################
#
# Defines common functions for use in Bash scripts.
#
################################################################################

export COLOR_BOLD="\e[1m"
export COLOR_DIM="\e[2m"
export COLOR_INVERT="\e[7m"
export COLOR_RESET="\e[0m"
export COLOR_UNDERLINE="\e[4m"
export COLOR_BLACK="\e[30m"
export COLOR_BLUE="\e[34m"
export COLOR_CYAN="\e[36m"
export COLOR_GREEN="\e[32m"
export COLOR_MAGENTA="\e[35m"
export COLOR_RED="\e[31m"
export COLOR_WHITE="\e[37m"
export COLOR_YELLOW="\e[33m"

# -------------------------------------------------------------------------------
# Print header message.
#
# Arguments:
#   $1 (required) - The message to print
# -------------------------------------------------------------------------------
dots_header() {
    # Fill line with ruler character, reset cursor, move 2 cols right, and print
    printf "\n" &&
        printf -v _hr "%*s" 80 &&
        printf "%b" "${COLOR_BLUE}${_hr// /-}" &&
        printf "\r\033[2C%b\n" "[ ${1} ]${COLOR_RESET}" &&
        printf "\n"
}

# -------------------------------------------------------------------------------
# Print check message.
#
# Arguments:
#   $1 (required) - The message to print
# -------------------------------------------------------------------------------
dots_check() {
    # Fill line with ruler character, reset cursor, print message, reset curser
    # move 78 cols right
    printf -v _hr "%*s" 76 &&
        printf "%b" "${_hr// /.}" &&
        printf "\r%b" "$(_print_message info "${1}")" &&
        printf "\r\033[79C"
}

# -------------------------------------------------------------------------------
# Print input message.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
dots_input() {
    _conditional_print "$(_print_message input "${1}")" "${2:-false}"
}

# -------------------------------------------------------------------------------
# Print success message.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
dots_success() {
    _conditional_print "$(_print_message success "${1}")" "${2:-false}"
}

# -------------------------------------------------------------------------------
# Print debug message.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
dots_debug() {
    _conditional_print "$(_print_message debug "${1}")" "${2:-false}"
}

# -------------------------------------------------------------------------------
# Print notice message.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
dots_notice() {
    _conditional_print "$(_print_message notice "${1}")" "${2:-false}"
}

# -------------------------------------------------------------------------------
# Print info message.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
dots_info() {
    _conditional_print "$(_print_message info "${1}")" "${2:-false}"
}

# -------------------------------------------------------------------------------
# Print warning message.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
dots_warning() {
    _conditional_print "$(_print_message warning "${1}")" "${2:-false}"
}

# -------------------------------------------------------------------------------
# Print error message.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
dots_error() {
    _conditional_print "$(_print_message error "${1}")" "${2:-false}"
}

# -------------------------------------------------------------------------------
# Print error message and exit with error code.
#
# Arguments:
#   $1 (required) - The message to print
# -------------------------------------------------------------------------------
dots_fatal() {
    _conditional_print "$(_print_message fatal "${1}")" false
    dots_exit "1"
}

# -------------------------------------------------------------------------------
# Starts animated loading spinner
# -------------------------------------------------------------------------------
dots_start_spinner() {
    # hides the input cursor
    tput civis
    # start spinner sub-process
    _spinner "start" &
    # set global spinner PID
    DOTS_ANIMATION_PID=$!
    disown
    sleep "${SPINNER_DELAY:-0.15}"
}

# -------------------------------------------------------------------------------
# Stops animated loading spinner
#
# Arguments:
#  $1 (required) = Exit code status
# -------------------------------------------------------------------------------
dots_stop_spinner() {
    _spinner "stop" "${1}" "${DOTS_ANIMATION_PID}"
    unset DOTS_ANIMATION_PID
    tput cnorm # shows the input cursor
}

# -------------------------------------------------------------------------------
# Any actions that should be taken if the script is prematurely
# exited. Always call this function at the top of your script.
# -------------------------------------------------------------------------------
dots_cleanup() {
    # re-enable echoing of terminal input
    stty echo
    # shows the input cursor
    tput cnorm
    echo -n
    # delete temp files, if any
    if [[ -d "${DOTS_TMP_PATH}" ]]; then
        rm -r "${DOTS_TMP_PATH}"
    fi
}

# -------------------------------------------------------------------------------
# Call to exit the script.
# -------------------------------------------------------------------------------
dots_fail() {
    dots_cleanup
    if [[ "${DEBUG}" == "true" ]] || [[ "${DEBUG}" == "1" ]]; then
        dots_fatal "\nTrapped exit in function: '${FUNCNAME[*]}'."
    else
        dots_fatal "\nExiting."
    fi
}

# -------------------------------------------------------------------------------
# Non-destructive exit for when script exits naturally. Add this function at
# the end of the script.
#
# Arguments:
#   $1 (optional) - Exit code (defaults to 0)
# -------------------------------------------------------------------------------
dots_exit() {
    dots_cleanup
    exit "${1:-0}"
}

# -------------------------------------------------------------------------------
# Command failed, disable soft error checking, kill the spinner, and exit.
#
# Arguments:
#   $1 (required) - Error message
# -------------------------------------------------------------------------------
dots_command_fail() {
    set -e
    dots_stop_spinner 1
    dots_fatal "${1:-Exiting}"
}

# -------------------------------------------------------------------------------
# Removes previous lines from output.
#
# Arguments:
#  $1 (required) = Number of lines to remove
# -------------------------------------------------------------------------------
dots_erase_lines() {
    local count=${1:-1}
    while ((count > 0)); do
        tput cuu 1 && tput el
        ((count--))
    done
}

# -------------------------------------------------------------------------------
# Removes spaces from input.
#
# Arguments:
#  $1 (required) = Value to trim
# -------------------------------------------------------------------------------
dots_trim() {
    local var="$*"
    var="${var#"${var%%[![:space:]]*}"}"
    var="${var%"${var##*[![:space:]]}"}"
    printf "%s" "${var}"
}

# -------------------------------------------------------------------------------
# Asks the user for a yes/no answer.
#
# Arguments:
#  $1 (required) = Prompt message
# -------------------------------------------------------------------------------
dots_ask_bool() {
    local message="${1}"
    local options="[y|n]"
    local result
    local yn

    tput cnorm # shows the input cursor
    stty echo  # restores echo printing

    # ask for user input
    while true; do
        read -n 1 -r -s -p "$(dots_input "${COLOR_BOLD}${message} ${options}${COLOR_RESET}") " yn
        case "${yn}" in
        [Yy]*)
            result=1
            break
            ;;
        [Nn]*)
            result=
            break
            ;;
        *)
            printf "%b\n" "${COLOR_RED}Please answer Yes or No.${COLOR_RESET}"
            ;;
        esac
    done
    printf "\n"

    dots_continue="${result}"

    tput civis # hides the input cursor
    stty -echo # restores echo printing
}

# -------------------------------------------------------------------------------
# Asks the user for input.
#
# Arguments:
#  $1 (required) = Prompt message
# -------------------------------------------------------------------------------
dots_ask_input() {
    local message="${1}"
    local user_input=""

    tput cnorm # shows the input cursor
    stty echo  # restores echo printing

    # ask for user input
    read -r -e -p "$(dots_input "${COLOR_BOLD}${message}${COLOR_RESET}") " user_input
    dots_continue="${user_input}"

    tput civis # hides the input cursor
    stty -echo # restores echo printing
}

# -------------------------------------------------------------------------------
# Asks the user for sudo privileges.
# -------------------------------------------------------------------------------
dots_ask_sudo() {
    dots_warning "\nAdmin privileges are required, you may need to enter your password"
    sudo -v &>/dev/null
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &>/dev/null &
}

# -------------------------------------------------------------------------------
# Checks local system for prerequistes.
# -------------------------------------------------------------------------------
dots_dependencies() {
    local binaries=()
    local pass=1
    binaries=(
        "bash"
        "cp"
        "curl"
        "gcc"
        "git"
        "grep"
        "perl"
        "python3"
        "sed"
        "sudo"
        "tee"
    )

    dots_header "Checking for dependencies"
    dots_check "OS compatibility check"
    dots_start_spinner
    if [[ "${DOTS_OS}" != "darwin" ]] && [[ "${DOTS_OS}" != "linux" ]]; then
        dots_command_fail "The ${DOTS_OS} OS is not yet supported."
    fi
    if [[ "${DOTS_OS}" == "linux" ]] && ! python3 -mplatform | grep -qE 'Ubuntu|linuxkit'; then
        dots_command_fail "This ${DOTS_OS} distribution is not yet supported."
    fi
    dots_stop_spinner 0

    for binary in "${binaries[@]}"; do
        dots_check "Checking for '$(dots_notice "${binary}" true)'"
        dots_start_spinner
        if ! hash "${binary}" 2>/dev/null; then
            dots_stop_spinner 1
        else
            dots_stop_spinner 0
        fi
    done

    if [[ "${pass}" -eq 0 ]]; then
        dots_fatal "\n\nYou are missing the basic requirements for dotties, please fix and try again.\n"
    fi
}

# -------------------------------------------------------------------------------
# Clone dotfiles repo.
# -------------------------------------------------------------------------------
dots_clone() {
    if [[ ! -d "${DOTS_PATH}" ]]; then
        dots_check "\nCloning dotfiles into ${DOTS_PATH}"
        dots_start_spinner
        if ! git clone --quiet --recursive -b "${DOTS_BRANCH}" "${DOTS_URI}" "${DOTS_PATH}" 2>&1; then
            dots_command_fail "Failed cloning dotfiles repository!"
        fi
        dots_stop_spinner 0
    fi
}

# -------------------------------------------------------------------------------
# Create necessary directories.
# -------------------------------------------------------------------------------
dots_create_dirs() {
    local directories=()
    directories=(
        "${HOME}/.ssh"
        "${HOME}/.composer"
    )

    for directory in "${directories[@]}"; do
        dots_check "Creating '$(dots_warning "${directory}" true)'"
        dots_start_spinner
        if ! mkdir -p "${directory}"; then
            dots_command_fail "Failed to create directory!"
        fi
        dots_stop_spinner 0
    done
}

# -------------------------------------------------------------------------------
# Enable files from repo.
#
# Arguments:
#  $1 (required) = String "copy" or "symlink"
# -------------------------------------------------------------------------------
dots_enable_paths() {
    local command="${1}"
    local filename
    local destination

    # shellcheck disable=SC2044
    for file in $(find "${DOTS_PATH}/src" -path "${HOME}/.vim" -prune -o -name \*."${command}"); do
        filename=".$(basename "${file%.*}")"
        destination="${HOME}/${filename}"

        if [[ -e "${destination}" ]]; then
            dots_ask_bool "'${filename}' already exists, overwrite?"
            if [[ -z "${dots_continue}" ]]; then
                dots_erase_lines 1
                dots_check "Skipping '$(dots_notice "${filename}" true)'"
                dots_start_spinner
                dots_stop_spinner 0
                continue
            else
                # reset output
                dots_erase_lines 1
                rm -Rf "${destination}"
            fi
        fi

        if [[ "${command}" == "copy" ]]; then
            dots_check "Copying  '$(dots_notice "${filename}" true)' → '$(dots_warning "${destination}" true)'"
            dots_start_spinner
            if ! cp "${file}" "${destination}"; then
                dots_stop_spinner 1
            else
                dots_stop_spinner 0
            fi
        elif [[ "${command}" == "symlink" ]]; then
            dots_check "Linking  '$(dots_notice "${filename}" true)' → '$(dots_warning "${destination}" true)'"
            dots_start_spinner
            if ! ln -nfs "${file}" "${destination}"; then
                dots_stop_spinner 1
            else
                dots_stop_spinner 0
            fi
        else
            dots_command_fail "Unrecognized command."
        fi
    done
}

# -------------------------------------------------------------------------------
# Copy assets.
# -------------------------------------------------------------------------------
dots_copy_assets() {
    local font_path="${HOME}/Library/Fonts"

    dots_check "Copying font assets"
    dots_start_spinner
    if ! cp "${DOTS_PATH}/assets/fonts/"* "${font_path}/" &>/dev/null; then
        dots_stop_spinner 1
    else
        dots_stop_spinner 0
    fi
}

# -------------------------------------------------------------------------------
# Generate new SSH Key.
# -------------------------------------------------------------------------------
dots_generate_keys() {
    local key_path="${HOME}/.ssh/${DOTS_SSHKEY}"

    dots_ask_bool "Do you want to generate a new SSH key?"
    if [[ -z "${dots_continue}" ]]; then
        dots_erase_lines 1
        dots_check "Skipping key generation"
        dots_start_spinner
        dots_stop_spinner 0
    else
        dots_erase_lines 1
        if [ ! -f "${key_path}" ]; then
            # the password prompt from `ssh-keygen` is passed through.
            dots_ask_input "Please provide an email address:"
            if ! ssh-keygen -t ed25519 -C "${dots_continue}" -f "${key_path}" -q; then
                dots_command_fail "Failed to generate new SSH key."
            fi
            dots_erase_lines 3
            dots_check "Generating '$(dots_warning "${key_path}" true)'"
            dots_start_spinner
            dots_stop_spinner 0
        else
            dots_check "Skipping '$(dots_notice "${key_path}" true)' already exists"
            dots_start_spinner
            dots_stop_spinner 0
        fi
    fi
}

# -------------------------------------------------------------------------------
# Messaging functions.
#
# Arguments:
#   $1 (required) - The message to print
#   $2 (optional) - Prevent newline from printing
# -------------------------------------------------------------------------------
_conditional_print() {
    if [[ "${2:-false}" == 'true' ]]; then
        printf "%s" "${1}"
    else
        printf "%s\n" "${1}"
    fi
}

# -------------------------------------------------------------------------------
# Internal function for printing output which handles coloring and suppression.
#
# Arguments:
#   $1 (required) - The type of alert to print
#   $2 (required) - The message to be printed to STDOUT
# -------------------------------------------------------------------------------
_print_message() {
    local alert_type="${1}"
    local message="${2}"
    local color
    local reset="${COLOR_RESET}"

    if [[ "${TERM}" == *"xterm"* ]]; then
        if [[ "${alert_type}" =~ ^(error|fatal) ]]; then
            color="${COLOR_RED}"
        elif [[ "${alert_type}" == "warning" ]]; then
            color="${COLOR_YELLOW}"
        elif [[ "${alert_type}" == "info" ]]; then
            color=""
        elif [[ "${alert_type}" == "notice" ]]; then
            color="${COLOR_CYAN}"
        elif [[ "${alert_type}" == "success" ]]; then
            color="${COLOR_GREEN}"
        elif [[ "${alert_type}" == "debug" ]]; then
            color="${COLOR_BOLD}${COLOR_MAGENTA}"
        elif [[ "${alert_type}" == "input" ]]; then
            color="${COLOR_MAGENTA}"
        else
            color=""
        fi
    else
        # don't use colors on pipes or non-recognized terminals
        color=""
        reset=""
    fi

    _write_to_screen() {
        printf "%b\n" "${color}${message}${reset}"
    }
    _write_to_screen
}

# -------------------------------------------------------------------------------
# Prints animated loading spinner
#
# Arguments:
#  $1 (required) = String "start" or "stop"
#  $2 (optional) = Exit code status
#  $3 (optional) = On stop, spinner function PID
# -------------------------------------------------------------------------------
_spinner() {
    local animation=('⠋' '⠙' '⠹' '⠸' '⠼' '⠴' '⠦' '⠧' '⠇' '⠏')
    local delay="${SPINNER_DELAY:-0.15}"
    local command="${1}"
    local exit_code="${2:-}"
    local spinner_pid="${3:-}"

    case "${command}" in
    start)
        printf "%b" "${COLOR_MAGENTA}"
        while ps a | awk '{print $1}' | grep -q $$; do
            for i in "${animation[@]}"; do
                printf "\b%s" "${i}"
                sleep "${delay}"
            done
        done
        ;;
    stop | *)
        if [[ -z "${spinner_pid}" ]]; then
            dots_fatal "No process is running!"
        fi
        kill "${spinner_pid}" &&
            wait "${spinner_pid}" >/dev/null 2>&1
        spinner_pid=
        if [[ "${exit_code}" -eq 0 ]]; then
            dots_success "\b✔\n" true
        else
            dots_error "\b✘\n" true
        fi
        tput cnorm # shows the input cursor
        ;;
    esac
}

# -------------------------------------------------------------------------------
# Sources script helper files.
# -------------------------------------------------------------------------------
_import_helpers() {
    local files_to_source=()
    files_to_source=(
        "${DOTS_SCRIPT_PATH}/helpers/brews.sh"
        "${DOTS_SCRIPT_PATH}/helpers/git.sh"
        "${DOTS_SCRIPT_PATH}/helpers/homebrew.sh"
        "${DOTS_SCRIPT_PATH}/helpers/macos/xcode.sh"
        "${DOTS_SCRIPT_PATH}/helpers/vim.sh"
        "${DOTS_SCRIPT_PATH}/helpers/zsh.sh"
    )
    for source_file in "${files_to_source[@]}"; do
        [[ ! -f "${source_file}" ]] && {
            dots_fatal "Can not find source file '${source_file}'."
        }
        # shellcheck source=/dev/null
        . "${source_file}"
    done
}
