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

# Start xfwm4 and capture the PID
xfwm4 --display :$DISPLAY_NUMBER &
XFWM4_PID=$!
sleep 2

# Ensure the xfwm4 PID is valid
if [ -z "$XFWM4_PID" ]; then
    echo "Failed to start xfwm4"
    exit 1
fi

# Save xfwm4 PID to file
echo $XFWM4_PID > $HOME/.xvfb_xfwm4_$DISPLAY_NUMBER.pid

echo "Xvfb started on display :$DISPLAY_NUMBER with PID $XVFB_PID"
echo "xfwm4 PID $XFWM4_PID saved to $HOME/.xvfb_xfwm4_$DISPLAY_NUMBER.pid"
