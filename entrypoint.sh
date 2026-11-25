#!/bin/sh
set -e
if [ -z "$UUID" ]; then echo "UUID env var is required"; exit 1; fi
if [ -z "$WS_PATH" ]; then echo "WS_PATH env var is required"; exit 1; fi
WS_PATH="${WS_PATH#/}"
PORT="${PORT:-8080}"
cat > /app/config.json <<JSON
{
  "log": {"loglevel": "warning"},
  "inbounds": [{
    "port": $PORT,
    "protocol": "vless",
    "settings": {"clients": [{"id": "$UUID"}], "decryption": "none"},
    "streamSettings": {"network": "ws", "wsSettings": {"path": "/$WS_PATH"}}
  }],
  "outbounds": [{"protocol": "freedom", "settings": {}}]
}
JSON
exec /app/xray run -config /app/config.json
