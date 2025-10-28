with open('.git/filter-repo/rename/old-name', 'r') as file:
	old_name = file.read().strip()

with open('.git/filter-repo/rename/old-email', 'r') as file:
	old_email = file.read().strip()

with open('.git/filter-repo/rename/new-name', 'r') as file:
	new_name = file.read().strip()

with open('.git/filter-repo/rename/new-email', 'r') as file:
	new_email = file.read().strip()

if commit.author_name.decode('utf-8') == old_name and commit.author_email.decode('utf-8') == old_email:
		commit.author_name = new_name.encode('utf-8')
		commit.author_email = new_email.encode('utf-8')
if commit.committer_name.decode('utf-8') == old_name and commit.committer_email.decode('utf-8') == old_email:
		commit.committer_name = new_name.encode('utf-8')
		commit.committer_email = new_email.encode('utf-8')
