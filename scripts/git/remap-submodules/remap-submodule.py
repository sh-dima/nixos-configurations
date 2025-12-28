#!/usr/bin/env python3
# git remap ./path/to/submodule ./path/to/commit/map
import sys
import os
import subprocess

arguments_count = len(sys.argv)

if arguments_count != 3:
	print("Invalid usage!")
	print("git remap ./path/to/submodule ./path/to/commit/map")
	exit(1)

submodule_path = sys.argv[1]
commit_map_path = sys.argv[2]

print(f"Remapping submodule at {submodule_path}")
print(f"Using commit map at {commit_map_path}")

commit_list: list[str]

with open(commit_map_path) as file:
	commit_list = file.readlines()[1:]

commit_map: dict[str, str] = {}

for entry in commit_list:
	split = entry.strip().split(" ")

	first = split[0]
	second = split[1]

	commit_map[first] = second

subprocess.run(["git", "submodule", "deinit", "-f", submodule_path])

env = os.environ.copy()
env["GIT_SEQUENCE_EDITOR"] = f"\"{os.path.dirname(__file__)}/edit_script.sh\""

subprocess.run(
	["git", "rebase", "-i", "--root"],
	check=True,
	env=env
)

env["GIT_EDITOR"] = "echo"

while os.path.exists(".git/rebase-merge/"):
	if os.path.exists(submodule_path):
		subprocess.run(["git", "submodule", "update", "--init"])
		subprocess.run(["git", "restore", "--staged", "."])

		rebase_head = subprocess.run(["git", "rev-parse", "REBASE_HEAD"], capture_output=True).stdout.strip().decode("utf-8")
		current_commit_hash = subprocess.run(["git", "rev-parse", f"{rebase_head}:{submodule_path.removesuffix("/")}"], capture_output=True).stdout.strip().decode("utf-8")
		mapped_commit = commit_map[current_commit_hash]

		os.chdir(submodule_path)
		print(f"[{os.getcwd()}] {current_commit_hash} -> {mapped_commit}")
		subprocess.run(["git", "checkout", mapped_commit])
		os.chdir("..")

	subprocess.run(["git", "add", "."])
	subprocess.run(["git", "rebase", "--continue"], env=env)
