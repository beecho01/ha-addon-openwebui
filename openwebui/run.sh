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

# Set data directory
export DATA_DIR="/data"

# Configure for ingress
if [[ -n "${SUPERVISOR_TOKEN:-}" ]]; then
  # We're running in Home Assistant
  echo "Running in Home Assistant with ingress"
  
  # Get the ingress path from the addon info
  ADDON_SLUG="openwebui"
  ADDON_INFO=$(curl -s -H "Authorization: Bearer ${SUPERVISOR_TOKEN}" http://supervisor/addons/${ADDON_SLUG}/info)
  INGRESS_PATH=$(echo "${ADDON_INFO}" | jq -r '.data.ingress_url' | sed 's/^\///' | sed 's/\/$//')
  
  if [[ -n "${INGRESS_PATH}" && "${INGRESS_PATH}" != "null" ]]; then
    # Format the path correctly for the application
    echo "Detected ingress path: /${INGRESS_PATH}"
    export WEBUI_BASE_PATH="/${INGRESS_PATH}"
    export UVICORN_ROOT_PATH="/${INGRESS_PATH}"
  else
    echo "Warning: Could not determine ingress path from supervisor API"
  fi
fi

# Based on the official Dockerfile, Open WebUI starts with:
# CMD [ "bash", "start.sh"] from /app/backend
if [[ -f /app/backend/start.sh ]]; then
    echo "Starting Open WebUI with base path: ${WEBUI_BASE_PATH:-/}"
    cd /app/backend
    exec bash start.sh
else
    echo "ERROR: Cannot find /app/backend/start.sh" >&2
    exit 1
fi
