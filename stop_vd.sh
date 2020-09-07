#!/bin/sh

if [ $# -eq 0 ]
then
    echo "Usage: $0 new_display_number"
    exit
fi

kill `cat $HOME/.xvfb_xfwm4_$1.pid`
rm $HOME/.xvfb_xfwm4_$1.pid 
