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
        URL=""
        while [[ "${URL}" != *".tar.gz" ]]; do
          printf "%b\n" "${PURPLE}[PROMPT]${RESET} Please provide the URL where the Go tar.gz file will be downloaded from:"
          read -r go_url
          if [[ ${go_url} != *".tar.gz" ]]; then
            echo "The URL needs to refer to a *.tar.gz file"
          else
            URL="${go_url}"
          fi
        done

        # Check if the tar is already in /tmp
        filepath="$( echo -n "${go_url}" | rev | cut -d '/' -f 1 | rev )"
        echo "Seeing if file exists in /tmp/${filepath}"

        if ! [ -f "/tmp/${filepath}" ]; then
          echo "Downloading Go package from ${go_url} to /tmp"
          wget "${go_url}" -P /tmp
          echo "Finished downloading Go"
        else
          file "/tmp/${filepath}"
          echo "File exists"
        fi

        sudo tar -C /usr/local -xzf "$(find /tmp/* -type f -name 'go*.tar.gz')"
        echo "Finished unzipping to /usr/local/go"
        # Create symlink in ~/.local/bin to the go bin
        mkdir -p ${HOME}/.local/bin
        ln -s /usr/local/go/bin/go ${HOME}/.local/bin/go
        file /usr/local/go/bin/go
      fi
    fi

  fi
fi

###############################################################################
