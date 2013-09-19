import os
import re
import string
import subprocess
from collections import defaultdict
from nltk.corpus import stopwords
from nltk import NaiveBayesClassifier
import nltk.classify
from nltk.tokenize import wordpunct_tokenize

from bayesFilter_ngrams import indicate_word, label_features, evalute_classififer

# fetch corpora from enron emails into list of files
def main():
	ng = abs(int(raw_input('Enter the degree of n-gram(1-4 is suggested): ')))
	while ng == 0 or ng > 4:
                ng = abs(int(raw_input('Please re-enter the degree (1-4): ')))
	
        ham_files = [x for x in subprocess.check_output('find pre/ham/ -type f', shell=True).splitlines()]
	spam_files = [x for x in subprocess.check_output('find pre/spam/ -type f', shell=True).splitlines()]
        # divide the emails into two parts, train set and test set
        #train_ham_filelist = ham_files[:int(len(ham_files)*0.3)]
        #train_spam_filelist = spam_files[:int(len(spam_files)*0.3)]
        train_spam_filelist = spam_files[:3000]
	train_ham_filelist = ham_files[:1000]

        #test_spam_filelist = spam_files[int(len(spam_files)*0.3):]
        #test_ham_filelist = ham_files[int(len(ham_files)*0.3):]
        test_spam_filelist = spam_files[3000:9000]
	test_ham_filelist = ham_files[1000:3000]

        # label train and test data sets
        train_spam = label_features(train_spam_filelist, 'spam', ng)
        train_ham = label_features(train_ham_filelist, 'ham', ng)
        train_set = train_spam + train_ham
        test_spam = label_features(test_spam_filelist, 'spam', ng)
        test_ham = label_features(test_ham_filelist, 'ham', ng)

        # evaluate the Naive Bayes classifier with data sets
        evaluate_classifier(train_set, test_spam, test_ham)

if __name__ == '__main__':
        main()

