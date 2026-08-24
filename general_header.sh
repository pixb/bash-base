#!/usr/bin/env bash

# === Color ===
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

# === handing failures and errors. ===
set -euo pipefail

# === Time ===
TIME="$(date +%Y-%m-%d_%H-%M-%S)"
# === File Variable ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)" || exit 1
SCRIPT_NAME="$(basename "${BASH_SOURCE[0]}")"
FILE_NAME="${SCRIPT_NAME%.*}"
