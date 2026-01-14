#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" && pwd)"

export DISPLAY=:0
export XAUTHORITY=/home/andrewdmarques/.Xauthority

# Wait up to ~60s for X to come up
for i in $(seq 1 60); do
  if xset -q >/dev/null 2>&1; then
    break
  fi
  sleep 1
done

# If X still isn't up, log and exit (cron will retry next boot)
if ! xset -q >/dev/null 2>&1; then
  echo "X not ready; exiting"
  exit 1
fi

# Prevent blanking
xset s off
xset s noblank
xset -dpms

# Launch kiosk
chromium \
  --kiosk \
  --noerrdialogs \
  --disable-infobars \
  --disable-session-crashed-bubble \
  --disable-translate \
  "file://$DIR/echotouch_v1.html"
