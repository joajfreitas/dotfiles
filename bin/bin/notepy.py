import os

class Todo(list):
    def __init__(self):
        self.file = os.path.expanduser('~') + "/.todo"

    def read(self):
        for line in open(self.file).readlines():
            self.append(line)

    @property
    def print(self):
        for i, note in enumerate(self):
            print("{0}.\t {1}" .format(i, note) .expandtabs(4), end='')

