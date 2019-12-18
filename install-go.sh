#!/bin/bash
###############################################################################

set -e
set -o pipefail



###############################################################################

if ! command -v go > /dev/null; then
  printf "%b\n" "${PURPLE}[PROMPT]${RESET} Do you want to install Go? (${LIGHT_GREEN}yes${RESET})"
  read -r should_do

  # From recommendation documented at:
  # https://github.com/golang/go/wiki/Ubuntu

  if [ "${should_do}" = "yes" ]; then
    if ! sudo snap install go; then

      #########################################################################
      # Dependencies
      number_of_errors=0
      for bin in wget tar
      do
        if ! command -v ${bin} > /dev/null; then
          echo "${MAGENTA}Dependency ${GREEN}'${bin}'${MAGENTA} not on your path. ${GREEN}'${bin}'${MAGENTA} needs to be available.${RESET}"
          number_of_errors=$(( number_of_errors + 1 ))
        fi
      done
      #########################################################################

      if [ ${number_of_errors} -gt 0 ]; then
        echo "${MAGENTA}${number_of_errors} required dependencies not in path.${RESET}"
      else
        printf "%b\n" "${PURPLE}[PROMPT]${RESET} Please provide the URL where the Go tar.gz file will be downloaded from:"
        read -r go_url
        echo "Downloading Go package from ${go_url} to /tmp"
        wget "${go_url}" -P /tmp
        tar -C /usr/local -xzf "$(sudo find /tmp -type f -name 'go*.tar.gz')"
        # Create symlink in ~/.local/bin to the go bin
        ln -s /usr/local/go/bin/go ${HOME}/.local/bin/go
      fi
    fi

  fi
fi

###############################################################################
