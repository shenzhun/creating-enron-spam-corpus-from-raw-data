creating-enron-spam-corpus-from-raw-data
========================================

Enron corpus is a collection of datasets that contains spam messages, and ham messages. The raw data is used to create a spam corpus using python, nltk and shell script

Download
--------

Enron Spam datasets http://csmining.org/index.php/enron-spam-datasets.html

CMU Enron Email Dataset  http://www.cs.cmu.edu/~enron/

Details
--------
1. read files from directories
<pre><code>
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
</code></pre>

2. clean the raw data file by file 
<pre><code>
def clean_html(file):
    # First remove inline JavaScript/CSS:
    cleaned = re.sub(r"(?is)<(script|style).*?>.*?(</\1>)", "", file)
    # Then remove html comments. 
    cleaned = re.sub(r"(?s)<!--(.*?)-->[\n]?", "", cleaned)
    # Next remove the remaining tags:
    cleaned = re.sub(r"(?s)<.*?>", " ", cleaned)
    # Finally deal with whitespace
    cleaned = re.sub(r"&nbsp;", " ", cleaned)
    cleaned = re.sub(r"^$", "", cleaned)
    cleaned = re.sub("''|,", "", cleaned)
    cleaned = re.sub(r"  ", " ", cleaned)
    return cleaned
</code></pre>

3. create new pre/ directory and sub ham/ spam/ directories and put all processed files into pre/
<pre><code>
# clean raw data files one by one 
    for i in file_list:
	raw_html = open(i, 'r').read()
        cleaned_html = clean_html(raw_html)
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
	        f.write(cleaned_html)
</code></pre>

4. use naive bayes classifier to test the processed texts
https://github.com/shenzhun/training-bayes-spam-filter

Howto
------
Option 1. download [process_enron.sh](https://github.com/shenzhun/creating-enron-spam-corpus-from-raw-data/blob/master/process_enron.sh) and raw/, then run <code> sh process_enron.sh</code>, 

Option 2. download [process_enron.py](https://github.com/shenzhun/creating-enron-spam-corpus-from-raw-data/blob/master/process_enron.py) and raw/, then run <code> python process_enron.py </code>, 

then the cleaned files will be in pre/.

Links
------
1. Document Classification on Enron Email Dataset http://people.cs.umass.edu/~ronb/enron_dataset.html
2. UC Berkeley Enron Email Analysis Project http://bailando.sims.berkeley.edu/enron_email.html


