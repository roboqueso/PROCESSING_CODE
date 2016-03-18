#!/bin/bash
# see: https://www.lcdf.org/gifsicle/man.html
echo "START the magic"
#	$1 should contain full path to working directory
#	$2 is output file name
/usr/local/bin/gifsicle --transparent 255 --colors 32 --interlace -l -O3 -d5 $1frames/*.gif > $1out/$2

echo "removing frames"
/bin/rm $1frames/*

echo "END magic"