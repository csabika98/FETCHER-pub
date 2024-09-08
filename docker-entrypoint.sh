#!/bin/bash

# Start Xvfb, x11vnc, etc.
Xvfb :1 -screen 0 1396x1037x16 &
export DISPLAY=:1
echo "FETCHERALPHA" | x11vnc -storepasswd /etc/x11vnc.pass
x11vnc -display :1 -usepw -forever -rfbauth /etc/x11vnc.pass &

# Start the web server to serve noVNC
/opt/noVNC/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &
cd /opt/noVNC && python3 -m http.server 8080 &

# Start your application
exec "$@"


