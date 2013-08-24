#/bin/bash

# concatination all files into one 
rm -rf pre/

cd ./raw/ham/
find . -name '*tar.gz' -exec tar xvfz {} \; 
cd ../spam/
find . -name '*tar.gz' -exec tar xvfz {} \;
cd ../..

filelist=$(find raw/ -type f | sed '/tar.gz/d')
for i in $filelist
do

# get the path of cleaned files
echo processing $i
txt_path=$(echo $i | sed 's/raw/pre/g')
echo $txt_path

# get directory and sub directory of pre/
dir_path=$(echo $txt_path | grep -o '.*\/')
echo creating $dir_path

# create pre/ and its sub directory
mkdir -pv $dir_path

# lupper case to lower case
cat $i | tr '[:upper:]' '[:lower:]' | tee enron.raw.all | \

# clean html tags and store the result into pre/
sed -f sedfile > $txt_path

done

