#!/bin/sh

if [ $# -eq 0 ]; then
	set -- "."
fi

for directory in "$@"
do
	(
		cd "$directory"
		git log --all --format='%cN <%cE>' | sort -u
	)
done
