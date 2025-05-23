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
  
  # Handle ingress path configuration
  if [[ -n "${INGRESS_URL:-}" ]]; then
    # If Home Assistant provides INGRESS_URL, use it
    echo "Using provided INGRESS_URL: ${INGRESS_URL}"
    INGRESS_PATH="${INGRESS_URL#/}"
    INGRESS_PATH="${INGRESS_PATH%/}"
  else
    # Fallback method using generic path
    HOSTNAME=$(cat /etc/hostname)
    INGRESS_PATH="api/hassio_ingress/${HOSTNAME}"
    echo "Using fallback ingress path: ${INGRESS_PATH}"
  fi
  
  # Format the path correctly for the application
  export WEBUI_BASE_PATH="/${INGRESS_PATH}"
  export UVICORN_ROOT_PATH="/${INGRESS_PATH}"
  echo "Configured base paths:"
  echo "WEBUI_BASE_PATH=${WEBUI_BASE_PATH}"
  echo "UVICORN_ROOT_PATH=${UVICORN_ROOT_PATH}"
fi

# Based on the official Dockerfile, Open WebUI starts with:
# CMD [ "bash", "start.sh"] from /app/backend
if [[ -f /app/backend/start.sh ]]; then
    echo "Starting Open WebUI..."
    cd /app/backend
    exec bash start.sh
else
    echo "ERROR: Cannot find /app/backend/start.sh" >&2
    exit 1
fi
