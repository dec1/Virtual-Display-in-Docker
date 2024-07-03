#!/bin/sh

if [ $# -eq 0 ]; then
    echo "Usage: $0 new_display_number"
    exit 1
fi

DISPLAY_NUMBER=$1

# Start Xvfb and capture the PID
Xvfb :$DISPLAY_NUMBER -screen 0 1280x1024x24 &
XVFB_PID=$!
sleep 4

# Ensure the Xvfb PID is valid
if [ -z "$XVFB_PID" ]; then
    echo "Failed to start Xvfb"
    exit 1
fi

export DISPLAY=:$DISPLAY_NUMBER

# Start openbox and capture the PID
openbox &
OPENBOX_PID=$!
sleep 2

# Ensure the openbox PID is valid
if [ -z "$OPENBOX_PID" ]; then
    echo "Failed to start openbox"
    exit 1
fi

# Save openbox PID to file
echo $OPENBOX_PID > $HOME/.xvfb_openbox_$DISPLAY_NUMBER.pid

echo "Xvfb started on display :$DISPLAY_NUMBER with PID $XVFB_PID"
echo "openbox PID $OPENBOX_PID saved to $HOME/.xvfb_openbox_$DISPLAY_NUMBER.pid"
