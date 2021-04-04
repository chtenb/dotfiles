import sys
import os
import readchar
import pyclip
from pyshellout import ShellString

fp = os.fdopen(sys.stdout.fileno(), 'wb', 0)

lines = ShellString(sys.stdin.read())
print('\n'.join(f'{i}: {s}' for i,s in enumerate(lines.n)))

typednumber = b''
selectedlines = []

print("Select line numbers, press enter or (q)uit: ")

def add_digit():
    global typednumber
    index = int(typednumber.decode('utf-8'))
    if index < len(lines.n):
        selectedlines.append(index)
        l = len(typednumber)
        fp.write(b'\b' * l + b' ' * l + b'\b' * l) # Clear line
    else:
        print("Number to large")
    typednumber = b''

while 1:
    c = readchar.readchar()
    # print(repr(c))
    if 48 <= ord(c) <= 57:
        fp.write(c)
        typednumber += c
    if c == b'q':
        break
    if c in b'\r\n':
        if typednumber:
            add_digit()
        else:
            result = '\n'.join(lines.n[i] for i in selectedlines)
            pyclip.copy(result)
            break
    if c == b'\b':
        fp.write(b'\b \b')
        typednumber = typednumber[:-1]
    if len(str(len(lines.n))) <= len(typednumber):
        add_digit()
