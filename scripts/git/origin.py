#!/usr/bin/env python3
# git origin -> returns current origin
# git origin <url> -> sets or adds origin
import sys
import subprocess

arguments = sys.argv[1:]

if len(arguments) == 0:
	exit(subprocess.run(["git", "remote", "get-url", "origin"]).returncode)
else:
	try:
		process = subprocess.run(["git", "remote", "get-url", "origin"], capture_output=True)
		process.check_returncode()

		existing = process.stdout.decode("utf-8").strip()
	except:
		existing = None

	origin = arguments[0]

	print(f"{existing} -> {origin}")

	subprocess.run([
			"git",
			"remote",
			"set-url" if existing is not None else "add",
			"origin",
			origin
		])
