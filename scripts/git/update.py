#!/usr/bin/env python3
import os
import subprocess

from datetime import datetime

staged = subprocess.run(["git", "diff", "--cached", "--name-only"], capture_output=True).stdout.decode("utf-8").splitlines()

if len(staged) == 0:
	# Let Git handle the error message for this:
	exit(subprocess.run(["git", "commit"]).returncode)

latest = 0

try:
	with open(".git/prepare/time") as file:
		latest = float(file.read())
except:
	for file in staged:
		if not os.path.exists(file):
			continue

		changed_time = subprocess.run(["stat", file], capture_output=True).stdout.decode("utf-8").splitlines()[6].removeprefix("Change: ")
		fixed = changed_time[:26] + changed_time[29:]
		date = datetime.strptime(fixed, "%Y-%m-%d %H:%M:%S.%f %z")
		timestamp = date.timestamp()

		if timestamp > latest:
			latest = timestamp

	if latest == 0:
		raise ValueError("Invalid commit date!")

subprocess.run(["git", "commit", f"--date={latest}"])

try:
	os.remove(".git/prepare/time")
except:
	pass # File probably doesn't exist
