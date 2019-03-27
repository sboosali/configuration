#!/bin/bash
if [ "$#" -lt 1 ]; then
	echo "Illegal number of parameters"
	echo "Usage: $0 directory [border-size]"
	exit
fi
if [ ! -z $2 ]; then 
	border=$2
else
	border=65
fi
DIR=$1
mkdir $1/output
for filename in $1/input/*; do
	base=$(basename "$filename")
	realbase="${base%%.*}"
	dest=$1/output/$realbase-$border.png
	convert $filename -crop 671x960+37+40 -bordercolor black -border ${border}x${border} $dest
done
