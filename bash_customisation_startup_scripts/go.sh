#!/bin/bash

echo -e "${GRAY}Running ${BASH_SOURCE}"

###############################################################################
# Set GOPATH and path
mkdir -p "${HOME}/goworkspace/src"

# The default conventional GOPATH to store downloaded third party libraries
export GOPATH="${HOME}/go"
export PATH=${PATH}:"${GOPATH}/bin"

# Have a separate workspace to install your own source code in that is free of
# `go get ...` installed libraries
export GOPATH="${GOPATH}:${HOME}/goworkspace"

###############################################################################
