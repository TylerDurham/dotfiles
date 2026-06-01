#!/usr/bin/env bash

# Load environment variables
source "$(git rev-parse --show-toplevel)/install.d/envs.sh"

init $@

debug "REVERT: $REVERT"
