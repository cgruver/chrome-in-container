#!/usr/bin/env bash

if [ ! -d "${HOME}" ]
then
  mkdir -p "${HOME}"
fi
if [ ! -d ${HOME}/.config/google-chrome ]
then
  mkdir -p ${HOME}/.config/google-chrome
  touch ${HOME}/.config/google-chrome/'First Run'
fi

if ! whoami &> /dev/null
then
  if [ -w /etc/passwd ]
  then
    echo "${USER_NAME:-user}:x:$(id -u):0:${USER_NAME:-user} user:${HOME}:/bin/bash" >> /etc/passwd
  fi
  if [ -w /etc/group ]
  then
    echo "${USER_NAME:-user}:x:$(id -u):" >> /etc/group
  fi
fi

nohup /usr/bin/Xvnc :0 -nolisten tcp -UseIPv4 -interface lo -localhost -SecurityTypes None -rfbport 5900 -desktop chrome -nevershared -noclipboard -noreset -DisconnectClients -geometry 1280x1024 -depth 24 -verbose  > /tmp/xvnclog.out 2>&1 &

nohup /usr/bin/google-chrome --display=:0 --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --disable-plugins --disable-plugins-discovery --disable-notifications --disable-sync --mute-audio --dns-prefetch-disable --noremote --window-size=1280,1024 > /tmp/googlelog.out 2>&1 &

nohup /usr/bin/novnc_server --listen 6080 --web /usr/share/novnc --vnc localhost:5900 > /tmp/novnclog.out 2>&1 &

tail -f /dev/null
