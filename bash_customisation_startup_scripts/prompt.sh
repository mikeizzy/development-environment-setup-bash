#!/bin/bash

###############################################################################

echo -e "${GRAY}Running ${BASH_SOURCE[0]:-${(%):-%x}}"

function parse_git_dirty() {
  [[ $(git status 2> /dev/null | tail -n1) != *"working directory clean"* ]] && echo "*"
}

function parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1$(parse_git_dirty)/"
}

parse_git_branch() {
  git symbolic-ref --short HEAD 2> /dev/null
}

if [[ $SHELL == *"zsh"* ]]; then
  setopt PROMPT_SUBST
  autoload -U colors && colors
  PROMPT='%{%F{green}%}$(parse_git_branch)%{%F{none}%}$ '
else
  export PS1="\[${BOLD}${GREEN}\]\u \[$WHITE\]in \[$ORANGE\]\w\[$WHITE\]\$([[ -n \$(git branch 2> /dev/null) ]] && echo \" on \")\[$PURPLE\]\$(parse_git_branch)\[$WHITE\]\n\$ \[$RESET\]"
  export PS2="\[$ORANGE\]→ \[$RESET\]"
fi

