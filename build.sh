#!/bin/bash
set -e

echo "[FETCH] Installing Python dependencies..."
pip install -r requirements.txt

echo "[FETCH] Installing Node.js bgutil server..."
mkdir -p /tmp/bgutil-server

if [ ! -f "/tmp/bgutil-server/dist/server.js" ]; then
    echo "[FETCH] Cloning bgutil server..."
    cd /tmp
    git clone --depth 1 https://github.com/brainicism/bgutil-ytdlp-pot-provider.git bgutil-repo
    cd bgutil-repo/server
    npm install --omit=dev
    npm run build
    mkdir -p /tmp/bgutil-server
    cp -r dist /tmp/bgutil-server/
    cp -r node_modules /tmp/bgutil-server/
    echo "[FETCH] bgutil server built successfully"
fi

echo "[FETCH] Build complete!"
