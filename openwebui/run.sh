#!/bin/bash
set -euo pipefail

# Persist a stable secret key so login sessions survive restarts
SECRET_FILE="/data/secret_key.txt"
if [[ ! -f "${SECRET_FILE}" ]]; then
  echo "Generating secret key..."
  openssl rand -hex 32 > "${SECRET_FILE}"
fi
export WEBUI_SECRET_KEY="$(cat "${SECRET_FILE}")"

# Run OpenWebUI on port 8081 (internal only)
export PORT=8081 
export DATA_DIR="/data"

# Start nginx in background
echo "Starting nginx reverse proxy..."
nginx

# Start OpenWebUI
echo "Starting Open WebUI..."
cd /app/backend
exec bash start.sh
