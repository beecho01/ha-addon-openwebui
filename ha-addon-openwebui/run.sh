#!/bin/bash

# Export a consistent secret key to persist login sessions
if [ ! -f /data/secret_key.txt ]; then
  echo "Generating secret key..."
  openssl rand -hex 32 > /data/secret_key.txt
fi
export WEBUI_SECRET_KEY=$(cat /data/secret_key.txt)

# Optional: disable auth
# export WEBUI_AUTH=False

# Start Open WebUI
echo "Starting Open WebUI..."
exec bash /app/backend/start.sh
