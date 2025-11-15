#!/bin/sh
# A script to clone all Gists from a GitHub profile.

limit="$1"

if [ -z "$limit" ]; then
	limit=10
fi

echo "Cloning Gists with limit of $limit"

gh gist list --limit "$limit" | while read -r repository _; do
	gh gist clone "$repository" "$repository"
done

script_dir="$(dirname "$(realpath "$0")")"

# Rename folders
nix-shell -p python3 --command "\"$script_dir/rename_gists.py\""
