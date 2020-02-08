#!/bin/bash
###############################################################################

set -e
set -o pipefail

###############################################################################

printf "%b\n" "${PURPLE}[PROMPT]${RESET} Configure bash customisation [$(pwd)]? (${LIGHT_GREEN}yes${RESET})"
read -r should_do
if [ "${should_do}" = "yes" ]; then

  echo "Copying from $(pwd)/bash_customisation_startup_scripts to ${HOME}/"
  cp -R ./bash_customisation_startup_scripts ${HOME}/

  for file_to_append_to in .bashrc .bash_profile .zshrc; do
    line='for file in ${HOME}/bash_customisation_startup_scripts/{colours,prompt,go}.sh; do [ -r "${file}" ] && source "${file}"; done'

    if ! $(grep -Hlr "colours,prompt,go" ${HOME}/${file_to_append_to} > /dev/null); then
      echo "Adding bash customisation line to ${file_to_append_to}"
      echo "${line}" >> ${HOME}/${file_to_append_to}
    fi

    THIS_SHELL=$( printf ${SHELL} | cut -d '/' -f 3 )
    if [[ "${file_to_append_to}" == *"${THIS_SHELL}"* ]]; then
      source ${HOME}/${file_to_append_to}
    fi
  done
fi

###############################################################################
