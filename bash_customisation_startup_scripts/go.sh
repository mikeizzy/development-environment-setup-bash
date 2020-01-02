#!/bin/bash

echo -e "${GRAY}Running ${BASH_SOURCE}"

###############################################################################
# Set GOPATH and path
mkdir -p ${HOME}/goworkspace/src
export GOPATH="${HOME}/go"
export PATH=$PATH:"$(go env GOPATH)/bin"
export GOPATH=${GOPATH}:${HOME}/goworkspace

###############################################################################
