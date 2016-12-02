#!/usr/bin/env zsh

#------------------------------------------------------------------------------#

main() {
  source "${DOTS}/src/shell/aliases/zsh_aliases.zsh"
  source "${DOTS}/src/shell/aliases/$(get_os)/zsh_aliases.zsh"
}

main
