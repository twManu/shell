#!/usr/bin/python

import re, os, sys, glob, fnmatch


#doubleHome = os.path.dirname(os.path.dirname(os.path.dirname(os.environ["ROOTFS"])))

matches = []
for root, dirnames, filenames in os.walk('.'):
    for filename in fnmatch.filter(filenames, '*.pri'):
        fullName = os.path.join(root, filename)
        found = False
        with open(fullName) as fl:
            if 'nano_441' in fl.read():
                matches.append(fullName)
                print fullName
            else:
                print '   skip ', fullName

for filename in matches:
    bkName = filename+'.bak'
    os.system('mv '+filename+' '+bkName)
    with open(bkName) as inF:
        with open(filename, 'w') as outF:
            lines = inF.readlines()
            for line in lines:
                line = line.replace("/home/manu/cross/nano_441", "$ROOTFS")
                outF.write(line)

