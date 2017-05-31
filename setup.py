#!/usr/bin/env python3
import sys
import os
import subprocess


ln = "/bin/ln"
IGNORE = ['README.md','setup.py']


def main():

    home = os.environ.get('HOME') + '/'
    if not home:
        print("Error: home directory could not be located.")
        print("$HOME environment variable must be set properly.\n")
        exit(1)
    dotfiles = home + "dotfiles/"
    if not os.path.isdir(dotfiles):
        print("Error: dotfiles directory {} does not exist.\n".format(dotfiles))
        exit(1)
    for f in os.listdir(dotfiles): 
        if f in IGNORE:
            continue
        if f[0] == '.':
            continue
        if len(f) > 4 and f[-4:] == ".swp":
            continue
        dest = "{}/.{}".format(home,f)
        source = "{}/{}".format(dotfiles,f)
        subprocess.call([ln,'-s',source,dest])


if __name__ == "__main__":
    main()
