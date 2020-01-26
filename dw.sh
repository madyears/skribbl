#!/bin/sh

if [ $# -ne 2 ] ; then
	echo "$0 <length of first word> <length of second word>"
	exit 1
fi

cat doublewords.txt | grep -E "^.{$1} .{$2}$" --color=auto
