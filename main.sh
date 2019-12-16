#!/bin/bash
###############################################################################

set -e
set -o pipefail

source ./bash_customisation_startup_scripts/colours.sh

###############################################################################
# Dependencies

number_of_errors=0

for bin in bash echo printf
do
  if ! command -v ${bin} > /dev/null; then
    echo "${MAGENTA}Dependency ${GREEN}'${bin}'${MAGENTA} not on your path. You are using ${WHITE}${SHELL}${MAGENTA}. ${GREEN}'${bin}'${MAGENTA} needs to be available.${RESET}"
    number_of_errors=$(( number_of_errors + 1 ))
  fi
done

if [ ${number_of_errors} -gt 0 ]; then
  echo "${MAGENTA}${number_of_errors} required dependencies not in path.${RESET}"
fi

###############################################################################
bash ./install-bash-customisation.sh
bash ./install-go.sh
bash ./install-vim.sh
###############################################################################
