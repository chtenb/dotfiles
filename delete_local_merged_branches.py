"""
Delete local branches that are merged into master.
Before each operation, the user is asked for confirmation.
"""
import argparse

# This dependency can be found on github: https://github.com/Chiel92/python-shellout
from pyshellout import get, out, confirm


parser = argparse.ArgumentParser()
parser.add_argument('master',
                    help='Name of the master branch. Defaults to \'master\'.',
                    nargs='?', default='master')
args = parser.parse_args()
master = args.master


# Get merged branches
merged_branches = [line.strip() for line in
                   get(r'git branch --merged {}', master, critical=True).n]
merged_branches = [branch for branch in merged_branches
                   if branch != '' and not '*' in branch and not branch == master]

print('Merged local branches:')
for branch in merged_branches:
    print('    ' + branch)


print()
for branch in merged_branches:
    if confirm('Delete local branch {}?', branch):
        out('git branch -d {}', branch)

