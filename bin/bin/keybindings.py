#!/usr/bin/env python3

import sys, pprint

actions = ['kill', 'reload', 'restart', 'workspace', 'focus', 'move', 'split', 'layout', 'resize', 'fullscreen', 'sticky', 'border', 'exec']

def find_mod_key(config):
    """ Find mod key to use """
    mod = "Super"
    for setting in config:
        setting = setting.split()
        if len(setting) < 3:
            continue
        if setting[0] == "set":
            if setting[1] == "$mod":
                if setting[2] == "Mod4":
                    mod = "Super"
                elif setting[2] == "Mod1":
                    mod = "Alt"

    return mod

file = sys.argv[1]

with open(file) as file:
    config = file.readlines()

mod = find_mod_key(config)

def format_comment(comment):
    # remove # from comment
    if '#' in comment:
        index = comment.index('#')
    else:
        index = len(comment)
    return comment[index+2:]

def parse_keybind(keybind):
    keybind = keybind.split('+')
    modifiers = ""
    keys = ""
    for key in keybind:
        if key == "Shift" or key == "Control" or key == "Super" or key == "Alt":
            modifiers += ('+' if modifiers != '' else '') + key
        else:
            keys += ('+' if keys != '' or modifiers != '' else '') + key

    return modifiers, keys

print("\033[44m[i3]\033[49m")
for index, line in enumerate(config):
    line = line.split()
    if len(line) < 3:
        continue
    if line[0] == "bindsym":
        modifiers, keys = parse_keybind(line[1].replace('$mod', mod)) # replace mod in keybind
        description = format_comment(config[index-1]).replace('\n', '') # description is in the previous line
        print(f"\033[1m\033[30m{modifiers}\033[37m{keys} \033[37m \033[0m{description}")

#bindings = {}
#for line in config:
#    if '#' in line.strip(' '):
#        continue
#    if "bindsym" in line:
#        keys = line.split()[1:]
#        if bindings.get(keys[1]):
#            bindings[keys[1]].append((keys[0], " ".join(keys[2:])))
#        else:
#            bindings[keys[1]] = [(keys[0], " ".join(keys[2:]))]
#
#
#col_width1 = max((len(word[0]) for l in bindings.values() for word in l))
#col_width2 = max((len(word) for word in bindings.keys()))
#for action in actions:
#    binds = bindings.get(action)
#    if not binds:
#        continue
#    
#    print(f"\033[1;32m{action}\033[0;m")
#    for bind in binds:
#        print(" ".join(word.ljust(col_width1) for word in bind))
#
#    print("")

