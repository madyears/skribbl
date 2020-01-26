#!/bin/sh

if [ $# -lt 1 ] ; then
	echo "$0 <length of word>"
	exit 1
fi

len=$(echo "$@" | cut -d' ' -f1)
args=$(echo "$@" | cut -d' ' -f2-)

if [ $# -eq 1 ] ; then
	cat words.txt | grep "^\w\{$len\}$"
	exit 0
fi

cmd=""
regex=""
for a in $args ; do
	f=$(echo $a | grep -E '^[a-z][0-9][0-9]?$' | sed 's/\([a-z]\)/\1 /')
	c=$(echo "$f" | cut -d' ' -f1)
	i=$(echo "$f" | cut -d' ' -f2)
	i=$((i-1))
	if [ ! -z "$cmd" ] ; then
		cmd="$cmd |"
	fi
	regex="^.{$i}$c"
	cmd="$cmd grep -E $regex"
done

cmd="$cmd --color=auto"
cat words.txt | grep "^\w\{$len\}$" | eval "$cmd"

