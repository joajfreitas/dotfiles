#!/usr/bin/env python3

import os, sys
from datetime import date, datetime

t = date.today()
p = os.path.join("/home/joaj/vimwiki/diary", str(t) + ".wiki")

now = datetime.now()
h,m,s = now.hour, now.minute, now.second
    
ex = ""
if os.path.exists(p):
    with open(p, 'r') as f:
        ex = f.read()

string = ""
for word in sys.argv[1:]:
    string += word + " "

with open(p, 'w') as f:
    f.write(str(ex + "\n" + f"{h:02d}:{m:02d}:{s:02d} - {string}"))
