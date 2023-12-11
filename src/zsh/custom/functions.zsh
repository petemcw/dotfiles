#!/usr/bin/env zsh

# Docker
#-------------------------------------------------------------------------------#

# Stop all containers
function dstop() {
    docker stop $(docker ps -a -q)
}

# Remove all containers
function drm() {
    docker rm $(docker ps -a -f status=exited -q)
}

# Dockerfile build, e.g., dbu petemcw/test
function dbu() {
    docker build -t=$1 .
}

# Connect to a container
function dbash() {
    docker exec -it $1 bash
}

# Remove all untagged images
function drmi() {
    docker rmi $(docker images -f dangling=true -q)
}

# Remove all orphaned volumes (> v1.9)
function drmv() {
    docker volume rm $(docker volume ls -qf dangling=true)
}

# Remove all volumes by pattern
function drmvp() {
    docker volume ls | grep "$1" | awk '{print $2}' | xargs docker volume rm
}

# Reclaim space inside Docker Desktop VM
function dclean() {
    docker run --privileged --pid=host docker/desktop-reclaim-space
    ls -klsh ~/Library/Containers/com.docker.docker/Data/vms/0/data/Docker.raw
}

# PHP Compatability
function phpco() {
    docker run --init -v $PWD:/mnt/src:cached --rm -u "$(id -u):$(id -g)" frbit/phpco:latest $@
    return $?
}

# IP addresses
#-------------------------------------------------------------------------------#

function ips() {
    ifconfig | grep "inet " | awk '{ print $2 }'
}

function myip() {
    res=$(curl -s -k jsonip.com | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: ${echo_bold_green} $res ${echo_normal}"
}

# PHP
#-------------------------------------------------------------------------------#

function phpsize() {
    ps --no-headers -o "rss,cmd" -C ${1:-php-fpm} | awk '{ sum+=$1 } END { printf ("%d%s\n", sum/NR/1024,"M") }'
}

# Resources
#-------------------------------------------------------------------------------#

function memcpu() {
    echo "\n*** Top 10 CPU eating processes ***"
    ps auxc | sort -nr -k 3 | head -10
    echo "\n"
    echo "*** TOP 10 memory eating processes ***"
    ps auxc | sort -nr -k 4 | head -10
}

# Fuzzy search
#-------------------------------------------------------------------------------#

function fh() {
    eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# DDEV templates
#-------------------------------------------------------------------------------#

function ddev-setup() {
    if [ "${1}" = "" ]; then
        printf "%s\n" "Please specify a DDEV project name."
    else
        rsync -avz "${HOME}/Projects/_templates/ddev/magento2/" "${PWD}/" &&
            sed -i "s/SITENAME/${1}/g" "${PWD}/.ddev/config.yaml"
    fi
}

# Project directory shortcut
#-------------------------------------------------------------------------------#

function p() {
    if [ "${1}" = "" ]; then
        [ -d "${HOME}/Projects" ] && cd "${HOME}/Projects" || cd "${HOME}"
    else
        [ -d "${HOME}/Projects/${1}" ] && cd "${HOME}/Projects/${1}" || echo \
            "Error: the '${1}' project directory does not exist."
    fi
}

# Code Workspaces shortcut
#-------------------------------------------------------------------------------#

function w() {
    local workspaces_path="${WORKSPACES_PATH:-${HOME}/Projects/_workspaces}"

    if [[ -n "${VSCODE}" ]] && ! which ${VSCODE} &>/dev/null; then
        printf "%s\n" "Could not detect '${VSCODE}' flavor of VS Code."
        unset VSCODE
    fi

    if [[ -z "${VSCODE}" ]]; then
        if which code &>/dev/null; then
            VSCODE="code"
        elif which code-insiders &>/dev/null; then
            VSCODE="code-insiders"
        elif which codium &>/dev/null; then
            VSCODE="codium"
        else
            printf "%s\n" "Could not detect a valid VS Code CLI. Reinstall, and try again."
            exit 1
        fi
    fi

    if [[ -f "${workspaces_path}/${1}.code-workspace" ]]; then
        eval "${VSCODE} ${workspaces_path}/${1}.code-workspace"
    else
        printf "%s\n" "Usage: w <workspace name>"
    fi
}
