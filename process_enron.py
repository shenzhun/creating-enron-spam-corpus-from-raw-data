#!/bin/env python

import os
import re
import tarfile
import subprocess

raw_path = ['raw/ham/','raw/spam/']
for path in raw_path:
    for root, dir, files in os.walk(path):
	print root, dir, files
	for file in files:
            file_path = root+file
	    tar = tarfile.open(file_path)
	    names = tar.getnames()
	    tar.extractall(path)
	    tar.close()
    file_str = subprocess.check_output('find raw/ -type f', shell=True)
    file_list = [ x for x in file_str.splitlines() if not x.endswith('tar.gz')]
    for i in file_list:
	raw_html = open(i, 'r').read()
	with open(re.sub('raw', 'pre', i), 'w') as f:
	    f.write(raw_html)
	


