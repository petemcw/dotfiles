#!/usr/bin/env bash
################################################################################
#
# Defines methods for configuring Git.
#
################################################################################

# -------------------------------------------------------------------------------
# Configure Git author.
# -------------------------------------------------------------------------------
dots_configure_git() {
    local git_author_email=""
    local git_author_name=""
    local github_username=""
    local github_token=""
    local gitconfig_path="${HOME}/.gitconfig.local"

    if [ ! -f "${gitconfig_path}" ]; then
        dots_ask_input "Enter your Git author name:"
        git_author_name="${dots_continue}"

        dots_ask_input "Enter your Git author email:"
        git_author_email="${dots_continue}"

        dots_erase_lines 2
        dots_check "Writing '$(dots_warning .gitconfig.local true)'"
        dots_start_spinner
        if ! sed -e "s/AUTHOR_NAME/${git_author_name}/g" -e "s/AUTHOR_EMAIL/${git_author_email}/g" \
            "${DOTS_PATH}/src/git/gitconfig.local.dist" >"${HOME}/.gitconfig.local"; then
            dots_command_fail "Failed to write Git configuration."
        fi
        dots_stop_spinner 0

        dots_ask_bool "Do you want to configure a Github token?"
        if [[ -z "${dots_continue}" ]]; then
            dots_erase_lines 1
            dots_check "Skipping Github configuration"
            dots_start_spinner
            if ! sed -i -e "s/\[github\]//g" "${HOME}/.gitconfig.local"; then
                dots_command_fail "Failed to update Git configuration."
            fi
            dots_stop_spinner 0
        else
            dots_erase_lines 1

            dots_ask_input "Enter your Github username:"
            github_username="${dots_continue}"

            dots_ask_input "Enter your Github token:"
            github_token="${dots_continue}"

            dots_erase_lines 2
            dots_check "Updating '$(dots_warning .gitconfig.local true)'"
            dots_start_spinner
            if ! sed -i -e "s/\[github\]/\[github\]\n\n  username = ${github_username}\n  token = ${github_token}/g" \
                "${HOME}/.gitconfig.local"; then
                dots_command_fail "Failed to update Git configuration."
            fi
            dots_stop_spinner 0
        fi
    else
        dots_check "Skipping '$(dots_notice .gitconfig.local true)'"
        dots_start_spinner
        dots_stop_spinner 0
    fi
}
