#!/bin/bash

TIMEFILE=~/.timefile.tmp

echo "Using time file: $TIMEFILE"

if [ -f $TIMEFILE ] ; then
  rm $TIMEFILE
fi

touch ~/.timefile.tmp

for file in * ; do
  echo "Processing $file"
  if [ -d ./$file/.git ] ; then
    cd ./$file
    echo "Finding git logs"
    git pull --rebase
    git log --author=$1 --after=$2 --format="%ci|$file|%cn|%s" >> $TIMEFILE
    cd ..
  fi
done

cat $TIMEFILE | sort

if [ -f $TIMEFILE ] ; then
  rm $TIMEFILE
fi
