#/bin/bash

# concatination all files into one 
#cat $(find . -name *.txt)
rm -rf pre/

cd ./raw/ham/
find . -name '*tar.gz' -exec tar xvfz {} \; 
cd ../spam/
find . -name '*tar.gz' -exec tar xvfz {} \;
cd ../..

filelist=$(find raw/ -type f | sed '/tar.gz/d')
for i in $filelist
do
echo processing $i
txt_path=$(echo $i | sed 's/raw/pre/g')
echo $txt_path
dir_path=$(echo $txt_path | grep -o '.*\/')
echo creating $dir_path
mkdir -pv $dir_path
# lupper case to lower case
cat $i | tr '[:upper:]' '[:lower:]' | tee enron.raw.all | \

# remove html tags ans some special tags
sed -e 's/<[a-zA-Z\/][^>]*>//g' -e 's/&nbsp[;=]//g' \
    -e 's/&nbsp//g' -e 's/#//g' -e 's/#&*;//g' -e 's/&[0-9]*//g' | \

# remove blank lines
sed -e '/^$/d' -e 's/^ *//g' -e 's/ *$//g' -e 's/^=*//g' -e '/-\{2,\}/d' | tee issue.1 | \

# remove html tags between multilines 
sed -e 'N;N;N;s/<[a-z\/]*.*>/---------------/g' -e 'N;s/<[a-z\/]*.*/---------------/g' -e 'N;s/.*>/---------------/g' | \

# remove ;;;; lines
sed -e '/;\{3,\}/d' -e '/[a-z0-9]\{20,\}/d' | \

# remove duplacate tags
sed -e 's/[-_+]\{5,\}//g' -e 's/\$\{5,\}//g' > $txt_path

done

