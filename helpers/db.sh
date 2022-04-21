#!/usr/bin/env bash
################################################################################
#
# Defines methods for configuring MySQL.
#
################################################################################

# -------------------------------------------------------------------------------
# Configure mysql.
# -------------------------------------------------------------------------------
dots_configure_db() {
    local mysql_path="${HOME}/.my.cnf"

    if [ ! -f "${mysql_path}" ]; then
        dots_check "Writing '$(dots_warning "${mysql_path}" true)'"
        dots_start_spinner
        if ! sed -e "s|HOME_PATH|${HOME}|g" "${DOTS_PATH}/src/db/my.cnf.dist" >"${mysql_path}"; then
            dots_stop_spinner 1
        else
            dots_stop_spinner 0
        fi
    else
        dots_check "Skipping '$(dots_notice "${mysql_path}" true)'"
        dots_start_spinner
        dots_stop_spinner 0
    fi
}
