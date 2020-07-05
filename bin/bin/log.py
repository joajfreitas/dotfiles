#!/usr/bin/env python3

import os, sys
from datetime import date

if len(sys.argv) != 3:
    print("You fucked up the arguments")
    exit()

# args:
# log.py file string
with open(sys.argv[1]) as l:
    log = l.read()

lines = log.splitlines()
last_log = [line for line in lines if '##' in line][-1]
day, month, year = last_log[3:].split('/')
d = date(int(year), int(month), int(day))
today = date.today()

if d==today:
    s = f'* {sys.argv[2]}\n'
else:
    s = f"\n## {today.strftime('%d/%m/%Y')}\n* {sys.argv[2]}\n"

with open(sys.argv[1], 'a') as l:
    l.write(s)
