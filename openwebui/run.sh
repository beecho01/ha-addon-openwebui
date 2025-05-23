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
  if [[ -n "${INGRESS_URL:-}" ]]; then
    # Use provided ingress URL if available
    INGRESS_PATH=$(echo "${INGRESS_URL}" | sed -e 's|^.*/ingress/|/api/hassio_ingress/|')
    echo "Configuring for ingress using INGRESS_URL: ${INGRESS_PATH}"
  else
    # Fallback to standard path format
    echo "INGRESS_URL not provided, using standard path format"
    INGRESS_PATH="/api/hassio_ingress/$(cat /etc/hostname)"
    echo "Configured fallback ingress path: ${INGRESS_PATH}"
  fi
  
  export WEBUI_BASE_PATH=""
  export UVICORN_ROOT_PATH="${INGRESS_PATH}"
fi

# Based on the official Dockerfile, Open WebUI starts with:
# CMD [ "bash", "start.sh"] from /app/backend
if [[ -f /app/backend/start.sh ]]; then
    echo "Starting Open WebUI..."
    cd /app/backend
    exec bash start.sh
else
    echo "ERROR: Cannot find /app/backend/start.sh - the container structure may have changed" >&2
    
    # Provide debugging info if the expected structure isn't found
    echo "=== DEBUGGING CONTAINER STRUCTURE ==="
    find / -name "start.sh" 2>/dev/null || echo "No start.sh found anywhere"
    ls -la / || echo "/ listing failed"
    ls -la /app 2>/dev/null || echo "/app not found" 
    
    exit 1
fi
