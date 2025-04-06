#!/bin/bash

# Load add-on options (requires bashio)
WEBUI_AUTH=$(bashio::config 'webui_auth')
SECRET_KEY=$(bashio::config 'secret_key')

# Check if data already exists
if [ -f /data/users.db ]; then
  echo "WARNING: Data already exists. WEBUI_AUTH change will be ignored to preserve data."
else
  echo "Applying WEBUI_AUTH=${WEBUI_AUTH}"
  export WEBUI_AUTH="${WEBUI_AUTH}"
fi

# Handle secret key
if [ -n "$SECRET_KEY" ]; then
  export WEBUI_SECRET_KEY="$SECRET_KEY"
  echo "Using provided secret key"
else
  if [ ! -f /data/secret_key.txt ]; then
    echo "Generating new secret key..."
    openssl rand -hex 32 > /data/secret_key.txt
  fi
  export WEBUI_SECRET_KEY=$(cat /data/secret_key.txt)
fi

# Start Open WebUI
echo "Starting Open WebUI..."
exec bash /app/backend/start.sh
echo "Open WebUI should be accessible on port ${webui_port:-3000}"