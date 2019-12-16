#!/bin/bash
###############################################################################

set -e
set -o pipefail

###############################################################################

printf "%b\n" "${PURPLE}[PROMPT]${RESET} Configure Vim? (${LIGHT_GREEN}yes${RESET})"
read -r should_do
if [ "${should_do}" = "yes" ]; then
  for line in "syntax on" "set paste" "filetype plugin indent on"
  do
    if ! $(cat ${HOME}/.vimrc | grep "${line}" > /dev/null); then
      echo "Adding '${line}' to .vimrc"
      touch ${HOME}/.vimrc
      echo "${line}" >> ${HOME}/.vimrc
    fi
  done
fi

###############################################################################
