#!/bin/bash
set -e

echo "==> Installing Docker..."
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

echo "==> Creating deploy directory..."
mkdir -p ~/arteflix
cd ~/arteflix

echo "==> Downloading compose files..."
curl -O https://raw.githubusercontent.com/kinooyume/arteflix/main/deploy/docker-compose.yml
curl -O https://raw.githubusercontent.com/kinooyume/arteflix/main/deploy/Caddyfile

echo "==> Done! Now:"
echo "1. Log out and back in (for docker group)"
echo "2. Run: docker compose up -d"
