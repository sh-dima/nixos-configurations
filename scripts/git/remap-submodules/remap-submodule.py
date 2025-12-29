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

subprocess.run(["git", "clean", "-fxd", "-f"], capture_output=True)

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

Path(".git/remap-submodule/").mkdir(parents=True, exist_ok=True)

commits: dict[str, str] = {}
old_commits_inverse: dict[str, str] = {}

if os.path.exists(".git/remap-submodule/commit-map"):
	with open(".git/remap-submodule/commit-map") as map_file:
		commit_list = map_file.readlines()

	print(f"Found existing commit map with {len(commit_list)} entries")

	for entry in commit_list:
		split = entry.strip().split(" ")

		first = split[0]
		second = split[1]

		old_commits_inverse[second] = first

	if len(old_commits_inverse) != len(commit_list):
		print("fatal: old commit map has duplicate keys")
		exit(2)

elapsed = 0

while os.path.exists(".git/rebase-merge/"):
	current_hash = subprocess.run(["git", "rev-parse", "REBASE_HEAD"], capture_output=True).stdout.strip().decode("utf-8")

	elapsed += 1

	subprocess.run(["git", "clean", "-fxd", "-f"], capture_output=True)

	print(f"[{current_hash[0:7]}] ({elapsed})", end="")

	for submodule_path in submodule_paths:
		if os.path.exists(submodule_path):
			subprocess.run(["git", "submodule", "update", "--init", submodule_path], capture_output=True, check=True)
			subprocess.run(["git", "restore", "--staged", submodule_path], capture_output=True, check=True)

			current_submodule_commit_hash = subprocess.run(["git", "rev-parse", f"{current_hash}:{submodule_path.removesuffix("/")}"], capture_output=True).stdout.strip().decode("utf-8")
			
			if current_submodule_commit_hash in commit_map.keys():
				submodule_mapped_commit = commit_map[current_submodule_commit_hash]

				os.chdir(submodule_path)

				print(f" [{Path(os.getcwd()).relative_to(repository_root)}: {current_submodule_commit_hash[0:7]} -> {submodule_mapped_commit[0:7]}]", end="")
				subprocess.run(["git", "checkout", submodule_mapped_commit], capture_output=True, check=True)
				os.chdir(repository_root)
			else:
				print(f" [invalid commit hash]", end="")
				submodule_mapped_commit = current_submodule_commit_hash

			break

	subprocess.run(["git", "add", "."], check=True)
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

	if current_hash in old_commits_inverse.keys():
		current_hash = old_commits_inverse[current_hash]
		print(f" (-> old {current_hash[0:7]})", end="")

	print(f" -> {edited_hash[0:7]}", end="")

	print()

	if current_hash in commits.keys():
		print(f"fatal: mapped the same commit ({current_hash[0:7]}) to multiple new commits ({commits[current_hash][0:7]}, {edited_hash[0:7]})")
		exit(1)

	if edited_hash in commits.values():
		inverted = {v: k for k, v in commits.items()}

		print(f"fatal: mapped more than one commit ({inverted[edited_hash][0:7], current_hash[0:7]}) to same new commit {edited_hash[0:7]}")
		exit(1)

	commits[current_hash] = edited_hash

with open(".git/remap-submodule/commit-map", "w") as file:
	lines = [f"{str(item[0])} {str(item[1])}\n" for item in commits.items()]
	file.writelines(lines)
