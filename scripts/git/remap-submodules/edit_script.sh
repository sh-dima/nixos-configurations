#!/bin/sh

# Git passes the path to the rebase todo file as $1
TODO_FILE="$1"

# Replace all leading 'pick' commands with 'edit'
sed -i 's/^pick /edit /' "$TODO_FILE"
