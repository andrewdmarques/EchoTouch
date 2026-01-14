# Kiosk Startup Script (Chromium) – README

This document explains how to set up and use the `start-kiosk.sh` script to automatically launch Chromium in kiosk mode on system boot.

All related files are stored in the same directory:

/home/andrewdmarques/Desktop/EchoTouch/

---

## Overview

The setup performs the following:

- Waits for the desktop environment to fully load
- Disables screen blanking and power management
- Launches Chromium in kiosk mode pointing to a local HTML file
- Automatically runs the script at system startup using `cron`
- Logs all output for troubleshooting

---

## File Locations

Project directory:

/home/andrewdmarques/Desktop/EchoTouch/

Files:

start-kiosk.sh  
echotouch_v1.html  
kiosk.log  
README.md (or README.txt)

---

## Create the Script

Open the file:

nano /home/andrewdmarques/Desktop/EchoTouch/start-kiosk.sh

Paste the following:

#!/bin/bash

# Wait for the desktop to be ready
sleep 60

# Prevent screen from sleeping/blanking
xset s off
xset s noblank
xset -dpms

# Launch Chromium in kiosk mode
chromium \
  --kiosk \
  --noerrdialogs \
  --disable-infobars \
  --disable-session-crashed-bubble \
  --disable-translate \
  --check-for-update-interval=31536000 \
  "file:///home/andrewdmarques/Desktop/EchoTouch/echotouch_v1.html"

Save and exit.

---

## Make the Script Executable

Run:

chmod +x /home/andrewdmarques/Desktop/EchoTouch/start-kiosk.sh

---

## Configure Auto-Start on Boot

Edit crontab:

crontab -e

Add this line:

@reboot DISPLAY=:0 /home/andrewdmarques/Desktop/EchoTouch/start-kiosk.sh >> /home/andrewdmarques/Desktop/EchoTouch/kiosk.log 2>&1

Save and exit.

---

## View Logs

Check log file:

cat /home/andrewdmarques/Desktop/EchoTouch/kiosk.log

Live monitoring:

tail -f /home/andrewdmarques/Desktop/EchoTouch/kiosk.log

---

## Notes

- The 60 second delay ensures the desktop and X server are ready.
- DISPLAY=:0 tells cron which screen to use.
- Chromium must be installed and available in PATH.
- Keeping all files in one directory simplifies maintenance and backups.

---

## Troubleshooting

If Chromium does not start:

- Verify the script is executable
- Confirm echotouch_v1.html exists in the directory
- Test running the script manually
- Check kiosk.log for errors
- Confirm display number is correct (:0)

---

End of file.
