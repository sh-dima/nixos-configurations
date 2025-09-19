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
	old_name = \"$old_name\"
	old_email = \"$old_email\"
	new_name = \"$new_name\"
	new_email = \"$new_email\"

	if commit.author_name.decode('utf-8') == old_name and commit.author_email.decode('utf-8') == old_email:
			commit.author_name = new_name.encode('utf-8')
			commit.author_email = new_email.encode('utf-8')
	if commit.committer_name.decode('utf-8') == old_name and commit.committer_email.decode('utf-8') == old_email:
			commit.committer_name = new_name.encode('utf-8')
			commit.committer_email = new_email.encode('utf-8')
" --force

if [ "$has_origin" = true ]; then
	git remote add origin "$origin"
fi
