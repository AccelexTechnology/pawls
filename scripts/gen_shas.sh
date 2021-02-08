#!/bin/sh

# Takes a DIR of pdfs and writes a sha.txt and names.json file
# as required by the PAWLS cli `pawls assign ...` command. Input
# DIR must be of the form:
# DIR
#   - file1
#       - file1.pdf
#   - file2
#       - file2.pdf
# The files are written to DIR/sha.txt and DIR/names.json

if [ $# -ne 1 ]; then
    echo "usage: $0 DIR"
  exit 1
fi;

DIR=$1


cd $DIR

# create sha.txt
ls -1 | grep -v "sha.txt" >> 'sha.txt'

json_str='{\n'
for x in ./*; do
    filename=$(basename "$x")
    if [ "$filename" = "sha.txt" ]; then
      continue
    else
      json_str=$json_str"\"${filename}\": \"${filename}\",\n"
    fi
done
# remove ',\n'
json_str=${json_str%,\\n}
json_str="$json_str\n}"
echo $json_str > 'names.json'
