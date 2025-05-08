#!/bin/bash
set -euo pipefail

# Persist a stable secret key so login sessions survive restarts
SECRET_FILE="/data/secret_key.txt"
if [[ ! -f "${SECRET_FILE}" ]]; then
  echo "Generating secret key..."
  openssl rand -hex 32 > "${SECRET_FILE}"
fi
export WEBUI_SECRET_KEY="$(cat "${SECRET_FILE}")"

# Optional: disable login screen
# export WEBUI_AUTH=false

# Set Open WebUI Port to 3000
export PORT=3000

# Start Open WebUI
echo "Starting Open WebUI on port ${PORT}"
exec bash /app/backend/start.sh
