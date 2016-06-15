"""
Archive branches that are merged into master.
This is done by tagging them as archive/<branchname> and removing them both locally and
remotely. Before each operation, the user is asked for confirmation.
"""
# This dependency can be found on github: https://github.com/Chiel92/python-shellout
from shellout import get, out, confirm


# Tag merged branches
merged_branches = [line.strip() for line in
                   get(r'git branch --merged master').n]
merged_branches = [branch for branch in merged_branches
                   if branch != '' and not '*' in branch and not branch == 'master']
archived_branches = []
for branch in merged_branches:
    if confirm('Archive branch {}?', branch):
        out('git tag archive/{} {}', branch, branch)
        archived_branches.append(branch)

if not archived_branches:
    exit('No branches archived. Bye.')

# Push archive tags to remote
print()
print('Created archive tags:')
for branch in archived_branches:
    print('    ' + branch)
if confirm('Push archive tags to remote?'):
    for branch in archived_branches:
        out('git push origin archive/{}', branch)


# Delete remote branches
print()
print('Corresponding remote branches:')
for branch in archived_branches:
    print('    origin/' + branch)
if confirm('Delete remote branches?'):
    for branch in archived_branches:
        out('git push origin :{}', branch)


# Delete local branches
print()
print('Corresponding local branches:')
for branch in archived_branches:
    print('    ' + branch)
if confirm('Delete local branches?'):
    for branch in archived_branches:
        out('git branch -d {}', branch)
