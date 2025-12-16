#!/usr/bin/env python3
import os

with open(".git/prepare/current") as file:
	current_files = [line.strip() for line in file.readlines()]

with open(".git/prepare/previous") as file:
	previous_files = [line.strip() for line in file.readlines()]

most_recent = 0

for previous_file in previous_files:
	if previous_file not in current_files:
		if not os.path.exists(previous_file):
			continue

		changed_time = os.path.getctime(previous_file) # Last time the file or file metadata was changed

		if changed_time > most_recent:
			most_recent = changed_time

with open(".git/prepare/time", 'w') as file:
	file.write(f"{most_recent}")
