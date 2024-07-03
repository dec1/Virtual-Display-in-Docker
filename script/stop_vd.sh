#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 display_number"
    exit 1
fi

PID_FILE="$HOME/.xvfb_xfwm4_$1.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "PID file $PID_FILE does not exist."
    exit 1
fi

PID=$(cat "$PID_FILE")

if [ -z "$PID" ]; then
    echo "PID file $PID_FILE is empty."
    exit 1
fi

if ! kill "$PID" 2>/dev/null; then
    echo "Failed to kill process with PID $PID."
    exit 1
fi

rm "$PID_FILE"
echo "Stopped virtual display :$1 and removed PID file."
