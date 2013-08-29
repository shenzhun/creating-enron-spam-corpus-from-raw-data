#!/bin/env python

import os
import re
import tarfile
import subprocess

# paths in raw/
raw_path = ['raw/ham/','raw/spam/']

for path in raw_path:
    for root, dir, files in os.walk(path):
	print 'Files in ' + root[:]

	# untar tar.gz files one by one
	for file in files:
	    print 'Processing ' + file
            file_path = root+file
	    tar = tarfile.open(file_path)
	    names = tar.getnames()
	    tar.extractall(path)
	    tar.close()
    
    # find all files in raw/
    file_str = subprocess.check_output('find raw/ -type f', shell=True)
    # extracte all files except tar.gz files
    file_list = [ x for x in file_str.splitlines() if not x.endswith('tar.gz')]
    # clean raw data files one by one 
    for i in file_list:
	raw_html = open(i, 'r').read()
        try:
	    # create dirs for preprocess file
	    pre_path = 'pre' + re.search('/.*/', i).group()
            os.makedirs(pre_path)
	except OSError:
	    # ignore exist dirs
	    pass
	finally:
	    # write preprocess files into pre/ directories
            with open(re.sub('raw/', 'pre/', i), 'w') as f:
	        f.write(raw_html)
	        f.close()
    print 'Done'	


