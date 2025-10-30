import re

from git_filter_repo import Commit

from re import Match
from typing import AnyStr

with open('.git/filter-repo/rename/old-name', 'r') as file:
	old_name = file.read().strip()

with open('.git/filter-repo/rename/old-email', 'r') as file:
	old_email = file.read().strip()

with open('.git/filter-repo/rename/new-name', 'r') as file:
	new_name = file.read().strip()

with open('.git/filter-repo/rename/new-email', 'r') as file:
	new_email = file.read().strip()

commit: Commit

if commit.author_name.decode('utf-8') == old_name and commit.author_email.decode('utf-8') == old_email:
		commit.author_name = new_name.encode('utf-8')
		commit.author_email = new_email.encode('utf-8')
if commit.committer_name.decode('utf-8') == old_name and commit.committer_email.decode('utf-8') == old_email:
		commit.committer_name = new_name.encode('utf-8')
		commit.committer_email = new_email.encode('utf-8')

trailer_pattern = re.compile(
	r'(?m)^(?P<tag>[A-Za-z-]+): '
	r'(?P<name>[^\n]+)(?= <[^\n]*>$)'
	r' '
	r'<(?P<email>[^\n]*)>$'
)

def replacer(match: Match[AnyStr]) -> AnyStr:
	tag = match.group('tag')
	name = match.group('name')
	email = match.group('email')

	if name == old_name and email == old_email:
			return f"{tag}: {new_name} <{new_email}>"
	else:
			return match.group(0)

message: str = commit.message.decode('utf-8')

commit.message = trailer_pattern.sub(replacer, message).encode('utf-8')
