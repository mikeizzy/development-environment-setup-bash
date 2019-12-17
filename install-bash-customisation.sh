#!/bin/bash
###############################################################################

set -e
set -o pipefail

###############################################################################

printf "%b\n" "${PURPLE}[PROMPT]${RESET} Configure bash customisation? (${LIGHT_GREEN}yes${RESET})"
read -r should_do
if [ "${should_do}" = "yes" ]; then
  file_to_append_to=".bashrc"
  line='for file in ${HOME}/bash_customisation_startup_scripts/{colours,prompt,go}.sh; do [ -r "${file}" ] && source "${file}"; done'

  if ! $(grep -Hlr "colours,prompt,go" ${HOME}/${file_to_append_to} > /dev/null); then
    echo "Adding bash customisation line to ${file_to_append_to}"
    echo "${line}" >> ${HOME}/${file_to_append_to}
  fi

  cp -R ./bash_customisation_startup_scripts ${HOME}/
  . ${HOME}/${file_to_append_to}
fi

###############################################################################
