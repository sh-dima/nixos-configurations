#!/usr/bin/env python3
import os
import subprocess

staged = subprocess.run(["git", "diff", "--cached", "--name-only"], capture_output=True).stdout.decode("utf-8").splitlines()

if len(staged) == 0:
	# Let Git handle the error message for this:
	exit(subprocess.run(["git", "commit"]).returncode)

latest = 0

for file in staged:
	changed_time = os.path.getctime(file) # Last time the file or file metadata was changed
	if changed_time > latest:
		latest = changed_time

if latest == 0:
	raise ValueError("Invalid commit date!")

subprocess.run(["git", "commit", f"--date={latest}"])
