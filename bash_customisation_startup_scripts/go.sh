#!/bin/bash
###############################################################################
# Set GOPATH and path
mkdir ${HOME}/goworkspace
export GOPATH="$(go env GOPATH)"
export PATH=$PATH:"$(go env GOPATH)/bin"
export GOPATH=${GOPATH}:${HOME}/goworkspace

###############################################################################
