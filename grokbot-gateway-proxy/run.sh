#!/bin/sh
# อ่าน options จาก Home Assistant supervisor แล้วส่งต่อให้ nginx template
set -e

OPTS=/data/options.json

UPSTREAM_HOST=$(jq -r '.upstream_host // "100.64.142.60"' "$OPTS")
UPSTREAM_PORT=$(jq -r '.upstream_port // "1340"' "$OPTS")
AUTH_TOKEN=$(jq -r '.auth_token // ""' "$OPTS")

export UPSTREAM_HOST UPSTREAM_PORT AUTH_TOKEN

echo "[run] proxy -> ${UPSTREAM_HOST}:${UPSTREAM_PORT} (token inject: $([ -n "$AUTH_TOKEN" ] && echo yes || echo no))"

exec /docker-entrypoint.sh nginx -g "daemon off;"
