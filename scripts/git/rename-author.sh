#!/bin/sh

old_name=$1
old_email=$2
new_name=$3
new_email=$4

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

git filter-repo --commit-callback "
	old_name = b\"$old_name\"
	old_email = b\"$old_email\"
	new_name = b\"$new_name\"
	new_email = b\"$new_email\"

	if commit.author_name == old_name and commit.author_email == old_email:
			commit.author_name = new_name
			commit.author_email = new_email
	if commit.committer_name == old_name and commit.committer_email == old_email:
			commit.committer_name = new_name
			commit.committer_email = new_email
" --force

if [ "$has_origin" = true ]; then
	git remote add origin "$origin"
fi
