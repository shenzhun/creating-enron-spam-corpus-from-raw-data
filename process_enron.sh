#!/bin/bash

# concatination all files into one 
#cat $(find . -name *.txt)

tarlist=$(find . -name *.tar.gz)
for j in $tarlist
do 
tar xvfz $j
done

filelist=$(find . -name *.txt)
for i in $filelist
do
echo processing $i
raw_path=$(echo $i | sed 's/[0-9].*//g')
txt_path=$(echo $i | sed 's/\/raw/\/pre/')
echo $txt_path
dir_path=$(echo $txt_path | sed 's/[0-9]\{5,\}.*txt//')
mkdir -p $dir_path
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
rm $i
rmdir $raw_path
done
