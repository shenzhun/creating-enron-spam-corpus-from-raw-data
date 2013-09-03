#!/bin/sh

cat $(find pre/ -type f) > all.pre
tr -sc '[A-Z][a-z]' '[\012*]' < all.pre | sort | uniq -c | sort -nr >  all.hist 

cat all.hist | less
