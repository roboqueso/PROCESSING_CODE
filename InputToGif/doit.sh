#!/bin/bash
echo "start"
/usr/local/bin/gifsicle /Users/ericfickes/Documents/Processing3/InputToGif/frames/*.gif > /Users/ericfickes/Documents/Processing3/InputToGif/out/$1
#gifsicle /Users/ericfickes/Documents/Processing3/InputToGif/frames/*.gif > out/output.gif
echo "stop"