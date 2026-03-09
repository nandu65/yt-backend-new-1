#!/bin/bash
set -e

echo "[FETCH] Installing Python dependencies..."
pip install -r requirements.txt

echo "[FETCH] Cloning bgutil PO token server v1.3.1..."
cd /opt/render/project
git clone --single-branch --branch 1.3.1 https://github.com/Brainicism/bgutil-ytdlp-pot-provider.git

echo "[FETCH] Building bgutil server..."
cd /opt/render/project/bgutil-ytdlp-pot-provider/server
npm ci
npx tsc

echo "[FETCH] Build complete! Server will start at runtime."
