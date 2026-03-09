#!/bin/bash
set -e

echo "[FETCH] Installing Python dependencies..."
pip install -r requirements.txt

echo "[FETCH] Installing Node.js bgutil server..."
mkdir -p /tmp/bgutil-server

# Download and setup bgutil server
pip show bgutil-ytdlp-pot-provider > /dev/null 2>&1

# Find the bgutil server files
BGUTIL_PATH=$(python3 -c "import bgutil_ytdlp_pot_provider; import os; print(os.path.dirname(bgutil_ytdlp_pot_provider.__file__))")
echo "[FETCH] bgutil found at: $BGUTIL_PATH"

# Clone bgutil server if not bundled
if [ ! -f "/tmp/bgutil-server/dist/server.js" ]; then
    echo "[FETCH] Downloading bgutil server..."
    cd /tmp
    git clone --depth 1 https://github.com/brainicism/bgutil-ytdlp-pot-provider.git bgutil-repo
    cd bgutil-repo/server
    npm install --omit=dev
    npm run build 2>/dev/null || true
    cp -r dist /tmp/bgutil-server/ 2>/dev/null || true
    cp -r node_modules /tmp/bgutil-server/ 2>/dev/null || true
    echo "[FETCH] bgutil server built"
fi

echo "[FETCH] Build complete!"
