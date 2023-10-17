"""
Merge a set of files, explicitly generating the files 'common', 'ours' and 'theirs'.
Allow the user to edit these files right before doing a 3 way merge.
Merge results are stored in another file, named '{filename}.result'.
"""
import re

# This dependency can be found on github: https://github.com/Chiel92/python-shellout
from pyshellout import get, out, confirm

kdiff3 = r'"c:/Program Files/KDiff3/kdiff3.exe"'


regex = re.compile(r'\d+ (\w+) (\d)\s*([\w/.-]+)')
lines = get('git ls-files -u').n
filenames = []
for line in lines:
    match = regex.match(line)
    sha = match.group(1)
    role = match.group(2)
    filename = match.group(3)

    # Only add the filename once
    if role == '1':
        filenames.append(filename)

    target = {
        '1': 'ours',
        '2': 'common',
        '3': 'theirs',
    }[role]

    out('git show {sha} > {filename}.{target}',
        sha=sha, filename=filename, target=target, critical=True, verbose=True)


print('You can now edit the generated files per triple (common, ours and theirs).')
print('After each triple, a 3-way merge is performed.')

for filename in filenames:
    if not confirm('Edit and merge {filename}?', filename=filename):
        continue

    out('vim {filename}.common {filename}.ours {filename}.theirs',
        filename=filename, verbose=True, critical=True)
    returncode = out('{kdiff3} {filename}.common {filename}.ours {filename}.theirs'
                     ' -o {filename}.result',
                     kdiff3=kdiff3, filename=filename, verbose=True)
    if returncode == 0 and confirm('Do you want to overwrite {filename} with {filename}.result'
                                   ' and mark the file as merged?', filename=filename):
        out('cp {filename}.result {filename}', filename=filename)
        out('git add {filename}', filename=filename)
        if confirm('Do you want to remove the merge artifacts?'):
            out('rm {filename}.common {filename}.ours {filename}.theirs {filename}.result',
                filename=filename)
