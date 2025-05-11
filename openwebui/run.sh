#!/bin/bash
set -euo pipefail

# Persist a stable secret key so login sessions survive restarts
SECRET_FILE="/data/secret_key.txt"
if [[ ! -f "${SECRET_FILE}" ]]; then
  echo "Generating secret key..."
  openssl rand -hex 32 > "${SECRET_FILE}"
fi
export WEBUI_SECRET_KEY="$(cat "${SECRET_FILE}")"

# Set port to match ingress configuration
export PORT=8080

# Start Open WebUI Message
echo "Starting Open WebUI on port ${PORT}"

# Identify the start script and run it
if [[ -x /app/backend/start.sh ]]; then
    START_SCRIPT=/app/backend/start.sh
elif [[ -x /app/start.sh ]]; then
    START_SCRIPT=/app/start.sh
elif [[ -x /opt/open-webui/backend/start.sh ]]; then
    START_SCRIPT=/opt/open-webui/backend/start.sh
else
    echo "ERROR: Cannot find Open WebUI start.sh" >&2
    exit 1
fi

exec bash "$START_SCRIPT"
