#!/usr/bin/env bash

nohup /usr/bin/Xvnc :0 -nolisten tcp -UseIPv4 -interface lo -localhost -SecurityTypes None -rfbport 5900 -desktop chrome -nevershared -noclipboard -noreset -DisconnectClients -geometry 1280x1024 -depth 24 -verbose  > /tmp/xvnclog.out 2>&1 &

nohup /usr/bin/google-chrome --no-sandbox --display=:0 --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --disable-plugins --disable-plugins-discovery --disable-notifications --disable-sync --mute-audio --dns-prefetch-disable --noremote --window-size=1280,1024 > /tmp/googlelog.out 2>&1 &

nohup /usr/bin/novnc_server --listen 3000 --web /usr/share/novnc --vnc localhost:5900 > /tmp/novnclog.out 2>&1 &

tail -f /dev/null

