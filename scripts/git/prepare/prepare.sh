#!/bin/sh
# Previously staged:
# * File 1
# * File 2
# Unstaged:
# * File 1 (more changes)
# * File 3
# git prepare File 1 File 3
# Currently staged:
# * File 1 (all changes)
# * File 3
# Unstaged:
# (nothing)

mkdir -p .git/prepare/

touch .git/prepare/previous
touch .git/prepare/current

(git ls-files --others --exclude-standard && git diff --name-only) > .git/prepare/previous

git add "$@"

(git ls-files --others --exclude-standard && git diff --name-only) > .git/prepare/current

script_dir="$(dirname "$(realpath "$0")")"
"$script_dir/prepare.py"
