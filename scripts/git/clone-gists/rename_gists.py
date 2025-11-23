#!/usr/bin/env python3
import os, subprocess

from typing import Dict, List

gists = os.listdir()

gist_files: Dict[str, List[str]] = {}

for gist in gists:
	gist_content = os.listdir(gist)

	gist_files[gist] = list(filter(lambda name: name != ".git", gist_content))

gist_files = {
	key: value
	for key, value in sorted(gist_files.items(), key=lambda item: len(item[1]))
}

def key(file: str):
	command = f"git log --follow --diff-filter=A --format=%ad --date=unix {file}"

	date = subprocess.run(
		command.split(" "),
		capture_output=True,
		text=True
	).stdout.strip().split("\n")[-1]

	return int(date)

for gist, files in gist_files.items():
	os.chdir(gist)
	gist_files[gist] = sorted(files, key=key)
	os.chdir("..")

gist_names = gist_files.keys()

j = 0
for gist_name in gist_names:
	gist_files_list = list(gist_files.values())[j]

	oldest_file = gist_files_list[0]
	os.rename(gist_name, oldest_file)

	j += 1
