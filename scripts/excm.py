#!/usr/bin/env python

# Extract comments from source files

import os, re

def dump_filename (filename):
    print "==== %s ====" % filename

rx_c = re.compile ("/\*(.+?)\*/", re.M | re.S)
rx_st = re.compile ("\"(.+?)\"", re.M | re.S)

def extract_from_c (contents):
    matches = rx_c.findall (contents)
    for match in matches:
        if 'Copyright' in match:
            continue
        if match.isupper ():
            continue
        if 'automatically generated' in match:
            continue
        print match
        print '---------------------'

def extract_from_st (contents):
    matches = rx_st.findall (contents)
    for match in matches:
        if 'Copyright' in match:
            continue
        print match

for dirpath, dirnames, filenames in os.walk("."):
    if '.svn' in dirpath or 'sconf' in dirpath:
        continue

    for filename in filenames:
        root, ext = os.path.splitext (filename)

        if ext not in ('.c', '.st', '.py'):
            continue

        filename = os.path.join (dirpath, filename)
        dump_filename (filename)

        f = file (filename)
        contents = f.read()
        if ext == '.c':
            extract_from_c (contents)
        elif ext == '.st':
            extract_from_st (contents)
        f.close ()
