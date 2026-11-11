#!/bin/sh
# Learning Design Hub - package installer: video-production (Educational Video Production standard)
# Install (macOS / Linux):
#   curl -fsSL https://raw.githubusercontent.com/learning-design-hub/ldh-packages/main/install/video-production.sh | sh
# Pin a version:
#   curl -fsSL https://raw.githubusercontent.com/learning-design-hub/ldh-packages/main/install/video-production.sh | LDH_VERSION=v1.1.0 sh
set -e
REPO="learning-design-hub/ldh-packages"
ID="video-production"
DEST="$(pwd)/$ID"
if [ -e "$DEST" ]; then
  echo "A folder named '$ID' already exists here. Remove it or run the command from another folder."
  exit 1
fi
if [ -n "$LDH_VERSION" ]; then
  URL="https://github.com/$REPO/releases/download/$LDH_VERSION/$ID.zip"
else
  URL="https://github.com/$REPO/releases/latest/download/$ID.zip"
fi
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
echo "Downloading $ID ..."
curl -fL --progress-bar "$URL" -o "$TMP/p.zip" || { echo "Download failed. Get it manually: $URL"; exit 1; }
echo "Extracting ..."
mkdir -p "$TMP/x"
if command -v ditto >/dev/null 2>&1; then
  ditto -x -k "$TMP/p.zip" "$TMP/x"
else
  unzip -q "$TMP/p.zip" -d "$TMP/x"
fi
INNER="$(find "$TMP/x" -mindepth 1 -maxdepth 1 -type d ! -name '__MACOSX' | head -n 1)"
mv "$INNER" "$DEST"
echo ""
echo "Installed: $DEST"
echo "Next: open the folder and start with the file whose name begins with 00 (start here)."
