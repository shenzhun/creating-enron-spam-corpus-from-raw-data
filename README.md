creating-enron-spam-corpus-from-raw-data
========================================

Enron corpus is a collection of datasets that contains spam messages, and ham messages. This project use the raw data to create a spam corpus using python, nltk and shell script

Download
--------

Enron Spam datasets http://csmining.org/index.php/enron-spam-datasets.html

CMU Enron Email Dataset  http://www.cs.cmu.edu/~enron/

Details
--------
1. read files from directories

2. clean the raw data file by file 

3. create new pre/ directory and sub ham/ spam/ directories

4. put processed fils into pre/

Howto
------
Option 1. download [process_enron.sh](https://github.com/shenzhun/creating-enron-spam-corpus-from-raw-data/blob/master/process_enron.sh) and raw/, then run <code> sh process_enron.sh</code>, 

Option 2. download [process_enron.py](https://github.com/shenzhun/creating-enron-spam-corpus-from-raw-data/blob/master/process_enron.py) and raw/, then run <code> python process_enron.py </code>, 

then the cleaned files will be in pre/.


