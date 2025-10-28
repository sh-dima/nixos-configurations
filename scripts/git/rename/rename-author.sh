#!/bin/sh

old_name="$1"
old_email="$2"
new_name="$3"
new_email="$4"

if [ "$old_name" == "" ] || [ "$old_email" == "" ]; then
	contributor_count=$(git contributors | wc -l | tr -d ' ')

	if [ "$contributor_count" -eq 1 ]; then
		contributor="$(git contributors)"

		old_name="$(echo "$contributor" | sed -E 's/^(.*) <.*>$/\1/')"
		old_email="$(echo "$contributor" | sed -E 's/^.* <(.*)>$/\1/')"
	else
		exit 255
	fi
fi

if [ "$new_name" == "" ]; then
	new_name="$(git config user.name)"
fi

if [ "$new_email" == "" ]; then
	new_email="$(git config user.email)"
fi

echo "Renaming $old_name <$old_email> to $new_name <$new_email>"

if git remote get-url origin > /dev/null 2>&1; then
	origin=$(git remote get-url origin)

	has_origin=true
else
	has_origin=false
fi

mkdir -p ./.git/filter-repo/rename/

echo "$old_name" > ./.git/filter-repo/rename/old-name
echo "$old_email" > ./.git/filter-repo/rename/old-email
echo "$new_name" > ./.git/filter-repo/rename/new-name
echo "$new_email" > ./.git/filter-repo/rename/new-email

script_dir="$(dirname "$(realpath "$0")")"

git filter-repo --commit-callback "$(cat "$script_dir/commit_callback.py")" --force

if [ "$has_origin" = true ]; then
	git remote add origin "$origin"
fi
