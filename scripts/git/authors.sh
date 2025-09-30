#!/bin/sh

if [ $# -eq 0 ]; then
	set -- "."
fi

for directory in "$@"
do
	(
		cd "$directory"
		git log --format='%aN <%aE>' | sort -u
	)
done
