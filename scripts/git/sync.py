#!/usr/bin/env python3
import sys
import subprocess
import re

remote = subprocess.run(
	["git", "rev-parse", "--abbrev-ref", "--symbolic-full-name", "@{u}"],
	capture_output=True,
	text=True,
).stdout.split("/")[0]

url = subprocess.run(
	["git", "remote", "get-url", remote],
	capture_output=True,
	text=True,
).stdout

connect = re.sub("/run/user/\\d+/", "", url).split("/")[0]

try:
	parsed = int(connect, 16)
except:
	print("Current remote is not a KDE Connect remote!")
	exit(1)

subprocess.run(
	["kioclient", "ls", f"kdeconnect://" + connect],
	capture_output=True,
)

subprocess.run(
	["git", "pull"],
)

subprocess.run(
	["git", "push"]
)
