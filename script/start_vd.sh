#!/bin/sh

if [ $# -eq 0 ]
then
    echo "Usage: $0 new_display_number"
    exit
fi

Xvfb :$1 -screen 0 1280x1024x24 &
PID=$!
sleep 4

export DISPLAY=:$1

XFWM4PID=$(pstree -T -p $PID | grep xfwm4 | sed 's/^.*xfwm4.*(\([0-9]\+\))/\1/')
echo $XFWM4PID > $HOME/.xvfb_xfwm4_$1.pid 
