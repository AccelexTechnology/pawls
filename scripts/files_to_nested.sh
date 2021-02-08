#!/bin/sh

# Takes a DIR of pdfs and converts from structure of
# DIR
#   - file1.pdf
#   - file2.pdf
# to a structure of:
# DIR
#   - file1
#       - file1.pdf
#   - file2
#       - file2.pdf

if [ $# -ne 1 ]; then
    echo "usage: $0 DIR"
  exit 1
fi;

DIR=$1

cd $DIR
for x in ./*.pdf; do
    mkdir "${x%.*}" && mv "$x" "${x%.*}"
done
