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

# Debug: Show container structure more thoroughly
echo "=== DEBUGGING CONTAINER STRUCTURE ==="
echo "Looking for start scripts:"
find / -name "start.sh" -o -name "entrypoint.sh" 2>/dev/null || echo "No start scripts found with those names"

echo "Checking Docker ENTRYPOINT/CMD:"
if [ -f /proc/1/cmdline ]; then
  cat /proc/1/cmdline | tr '\0' ' '; echo
fi

echo "Examining key directories:"
ls -la / || echo "/ listing failed"
ls -la /app || echo "/app not found" 
ls -la /opt || echo "/opt not found"

# Try to find Python and Open WebUI module
echo "Python installation:"
which python python3 || echo "Python not found in PATH"
python3 -m pip list | grep -i webui || echo "No webui package found"

# Try official paths first
if [[ -f /entrypoint.sh ]]; then
    echo "Found /entrypoint.sh, running it"
    exec bash /entrypoint.sh
elif [[ -x /app/backend/start.sh ]]; then
    echo "Running /app/backend/start.sh"
    START_SCRIPT=/app/backend/start.sh
    exec bash "$START_SCRIPT"
elif [[ -f /.dockerenv && -d /app ]]; then
    echo "Trying direct Python approach in Docker container"
    # Set data directory
    export DATA_DIR="/data"
    # Try to run using Python if installed
    if command -v python3 &>/dev/null; then
        cd /app
        echo "Running Open WebUI with Python in /app"
        exec python3 -m openwebui.serve
    else
        echo "Python not found"
    fi
else
    echo "ERROR: Cannot find a way to start Open WebUI" >&2
    exit 1
fi
