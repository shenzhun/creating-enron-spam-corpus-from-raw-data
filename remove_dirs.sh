#!/bin/sh

cd raw/ham/
rm -rf BG/ SH/ GP/
cd ../spam/
rm -rf beck-s/ farmer-d/ kaminski-v/ kitchen-l/ lokay-m/ williams-w3/
cd ../..
rm -rf pre/
tree raw/ -d
