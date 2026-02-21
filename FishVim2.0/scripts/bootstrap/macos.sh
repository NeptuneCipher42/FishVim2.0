#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
NVIM_CONFIG_DIR="${HOME}/.config/nvim"

if ! command -v brew >/dev/null 2>&1; then
  echo "[FishVim] Homebrew is required: https://brew.sh"
  exit 1
fi

echo "[FishVim] Installing macOS dependencies..."
brew update
brew install \
  fd \
  git \
  node \
  python \
  ripgrep \
  unzip

if ! command -v pynvim >/dev/null 2>&1; then
  python3 -m pip install --user --upgrade pynvim
fi

if [ -d "${REPO_ROOT}/config/nvim" ]; then
  echo "[FishVim] Installing Neovim config to ${NVIM_CONFIG_DIR}"
  mkdir -p "${HOME}/.config"
  rm -rf "${NVIM_CONFIG_DIR}"
  cp -R "${REPO_ROOT}/config/nvim" "${NVIM_CONFIG_DIR}"
else
  echo "[FishVim] WARNING: ${REPO_ROOT}/config/nvim not found. Skipping config copy."
fi

echo "[FishVim] Bootstrap complete. Start with: nvim"
