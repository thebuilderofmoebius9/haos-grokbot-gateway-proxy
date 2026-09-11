#!/bin/sh
# Read options from the Home Assistant supervisor and hand them to the nginx template
set -e

OPTS=/data/options.json

UPSTREAM_HOST=$(jq -r '.upstream_host // "100.64.142.60"' "$OPTS")
UPSTREAM_PORT=$(jq -r '.upstream_port // "1340"' "$OPTS")

export UPSTREAM_HOST UPSTREAM_PORT

echo "[run] proxy -> ${UPSTREAM_HOST}:${UPSTREAM_PORT} (Authorization pass-through)"

exec /docker-entrypoint.sh nginx -g "daemon off;"
