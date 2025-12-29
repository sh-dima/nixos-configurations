#!/usr/bin/env python3
# git remap ./path/to/commit/map ./path/to/submodule_1 ./path/to/submodule_2 ...
import sys
import os
import subprocess

from pathlib import Path

arguments_count = len(sys.argv)

if arguments_count < 3:
	print("Invalid usage!")
	print("git remap ./path/to/commit/map ./path/to/submodule_1 ./path/to/submodule_2 ...")
	exit(1)

commit_map_path = sys.argv[1]
submodule_paths = sys.argv[2:]

print(f"Remapping submodule '{submodule_paths}' using map '{commit_map_path}'")

commit_list: list[str]

with open(commit_map_path) as file:
	commit_list = file.readlines()[1:]

commit_map: dict[str, str] = {}

for entry in commit_list:
	split = entry.strip().split(" ")

	first = split[0]
	second = split[1]

	commit_map[first] = second

for submodule_path in submodule_paths:
	subprocess.run(["git", "submodule", "deinit", "-f", submodule_path], check=False)

env = os.environ.copy()
env["GIT_SEQUENCE_EDITOR"] = f"\"{os.path.dirname(__file__)}/edit_script.sh\""

subprocess.run(
	["git", "rebase", "-i", "--root"],
	check=True,
	env=env
)

env["GIT_EDITOR"] = "echo"

repository_root = os.getcwd()

commits: dict[str, str] = {}

while os.path.exists(".git/rebase-merge/"):
	current_hash = subprocess.run(["git", "rev-parse", "REBASE_HEAD"], capture_output=True).stdout.strip().decode("utf-8")

	for submodule_path in submodule_paths:
		for submodule_path in submodule_paths:
			subprocess.run(["git", "submodule", "deinit", "-f", submodule_path], check=False, capture_output=True)

		if os.path.exists(submodule_path):
			subprocess.run(["git", "submodule", "update", "--init"], capture_output=True)
			subprocess.run(["git", "restore", "--staged", "."], capture_output=True)

			current_submodule_commit_hash = subprocess.run(["git", "rev-parse", f"{current_hash}:{submodule_path.removesuffix("/")}"], capture_output=True).stdout.strip().decode("utf-8")
			submodule_mapped_commit = commit_map[current_submodule_commit_hash]

			os.chdir(submodule_path)

			print(f"[{Path(os.getcwd()).relative_to(repository_root)}] {current_submodule_commit_hash} -> {submodule_mapped_commit}")
			subprocess.run(["git", "checkout", submodule_mapped_commit], capture_output=True)
			os.chdir(repository_root)
			break

	subprocess.run(["git", "add", "."])
	subprocess.run(["git", "rebase", "--continue"], env=env, capture_output=True)

	rebase_in_progress = os.path.exists(".git/rebase-merge/")

	edited_hash = subprocess.run(
		[
			"git",
			"rev-parse",
			f"HEAD~{1 if rebase_in_progress else 0}"
		],
		capture_output=True,
		check=False
	).stdout.strip().decode("utf-8")

	if current_hash in commits.keys():
		print("fatal: mapped more than one commit to same new commit")
		exit(1)

	commits[current_hash] = edited_hash

Path(".git/remap-submodule/").mkdir(parents=True, exist_ok=True)

with open(".git/remap-submodule/commit-map", "w") as file:
	lines = [f"{str(item[0])} {str(item[1])}\n" for item in commits.items()]
	file.writelines(lines)
