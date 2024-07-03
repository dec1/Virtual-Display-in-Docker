#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 display_number"
    exit 1
fi

PID_FILE="$HOME/.xvfb_openbox_$1.pid"

if [ ! -f "$PID_FILE" ]; then
    echo "PID file $PID_FILE does not exist."
    exit 1
fi

PID=$(cat "$PID_FILE")

if [ -z "$PID" ]; then
    echo "PID file $PID_FILE is empty."
    exit 1
fi

# Kill the openbox process
if ! kill "$PID" 2>/dev/null; then
    echo "Failed to kill openbox process with PID $PID."
    exit 1
fi

# Kill the Xvfb process
XVFB_PID=$(pgrep -f "Xvfb :$1")
if [ ! -z "$XVFB_PID" ]; then
    if ! kill "$XVFB_PID" 2>/dev/null; then
        echo "Failed to kill Xvfb process with PID $XVFB_PID."
        exit 1
    fi
fi

rm "$PID_FILE"
echo "Stopped virtual display :$1 and removed PID file."
