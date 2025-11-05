#!/bin/sh
# A script to clone all repositories from a GitHub profile.

namespace="$1"
limit="$2"

if [ -z "$limit" ]; then
	limit=30
fi

echo "Cloning all Gists in namespace $namespace with repository limit of $limit"

gh repo list "$namespace" --limit "$limit" | while read -r repository _; do
	gh repo clone "$repository" "$repository"
done
