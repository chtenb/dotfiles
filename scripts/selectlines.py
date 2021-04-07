import sys
import os
import time
import readchar
import pyclip
from pyshellout import ShellString

fp = os.fdopen(sys.stdout.fileno(), 'wb', 0)

lines = ShellString(sys.stdin.read())
print('\n'.join(f'{i}: {s}' for i,s in enumerate(lines.n)))

typednumber = b''
selectedlines = []

print("Type line numbers, press enter or (q)uit: ")

def add_line():
    global typednumber
    index = int(typednumber.decode('utf-8'))
    if index < len(lines.n):
        selectedlines.append(index)
        msg = b' selected'
        fp.write(msg)
        time.sleep(0.3)
        l = len(typednumber + msg)
        fp.write(b'\b' * l + b' ' * l + b'\b' * l) # Clear line
    else:
        print("Number to large")
    typednumber = b''

while 1:
    c = readchar.readchar()
    if 48 <= ord(c) <= 57:
        fp.write(c)
        typednumber += c
    if c in b'q':
        sys.exit(1)
        break
    if c in b' ':
        if typednumber:
            add_line()
    if c in b'\r\n':
        if typednumber:
            add_line()
        else:
            result = '\n'.join(lines.n[i] for i in selectedlines)
            pyclip.copy(result)
            break
    if c in b'\b':
        fp.write(b'\b \b')
        typednumber = typednumber[:-1]
    if len(str(len(lines.n))) <= len(typednumber):
        add_line()
