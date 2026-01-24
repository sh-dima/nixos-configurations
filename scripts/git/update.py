#!/usr/bin/env python3
import os
import subprocess

from argparse import ArgumentParser, ArgumentDefaultsHelpFormatter
from datetime import datetime

import logging

staged = subprocess.run(["git", "diff", "--cached", "--name-only"], capture_output=True).stdout.decode("utf-8").splitlines()

if len(staged) == 0:
	# Let Git handle the error message for this:
	exit(subprocess.run(["git", "commit"]).returncode)

parser = ArgumentParser(
	formatter_class=lambda prog: ArgumentDefaultsHelpFormatter(prog, width=120, max_help_position=50)
)

parser.add_argument("-l", "--log-level", type=str, choices=[level for level in logging._nameToLevel.keys()], default="INFO", metavar="level", help="set logging level")
parsed = parser.parse_args()

logging.basicConfig(level=getattr(logging, parsed.log_level))

latest = 0

try:
	with open(".git/prepare/time") as file:
		latest = float(file.read())
except:
	for file in staged:
		if not os.path.exists(file):
			continue

		changed_time = subprocess.run(["stat", file], capture_output=True).stdout.decode("utf-8").splitlines()[6].removeprefix("Change: ")
		fixed = changed_time[:19] + changed_time[29:]
		date = datetime.strptime(fixed, "%Y-%m-%d %H:%M:%S %z")
		timestamp = date.timestamp()

		logging.debug(f"{file}: {date}")

		if timestamp > latest:
			latest = timestamp

	if latest == 0:
		raise ValueError("Invalid commit date!")

subprocess.run(["git", "commit", f"--date={latest}"])

try:
	os.remove(".git/prepare/time")
except:
	pass # File probably doesn't exist
