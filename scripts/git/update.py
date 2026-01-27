#!/usr/bin/env python3
import os
import sys
import subprocess

from pathlib import Path
from urllib.parse import quote

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

if os.path.exists(".git/prepare/time"):
	with open(".git/prepare/time") as file:
		latest = float(file.read())
else:
	for file in staged:
		if not os.path.exists(file):
			# If the deletion of a file is staged, it is impossible to know when that file was deleted.
			# For that reason, it is impossible to know what date and time should be attributed to the commit.
			# Therefore, the normal git commit functionality is used.

			# Unless we look in the trash to figure it out:
			trash = f"{Path.home()}/.local/share/Trash/"
			info = os.listdir(f"{trash}/info")

			date = None
			for trash_info in info:
				with open(f"{trash}/info/{trash_info}") as info_file:
					lines = info_file.readlines()

				path = lines[1].removeprefix("Path=").strip()
				target = quote(f"{os.getcwd()}/{file}").strip()

				if target == path:
					time = lines[2].removeprefix("DeletionDate=").strip()
					date = datetime.strptime(time, "%Y-%m-%dT%H:%M:%S") # Example: 2025-11-25T08:48:09

			if not date:
				logging.debug("Couldn't find date for deleted file. Using default commit behavior...")
				exit(subprocess.run(["git", "commit"]).returncode)
		else:
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
