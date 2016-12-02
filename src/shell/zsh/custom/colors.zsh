#!/usr/bin/env zsh

#------------------------------------------------------------------------------#

main() {
  if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && \
    infocmp gnome-256color &> /dev/null; then
    export TERM="gnome-256color"
  elif infocmp xterm-256color &> /dev/null; then
    export TERM="xterm-256color"
  fi

  source "$DOTS/src/shell/colors/$(get_os)/zsh_colors.zsh"
}

main
