# Self-hosting

Docker + Caddy on a VPS. Deploys automatically via GitHub Actions on every release.

## Setup

You need a VPS (Debian 12+), a domain, and Docker installed:

```bash
curl -fsSL https://get.docker.com | sudo sh
sudo usermod -aG docker $USER
```

Log out and back in, then:

```bash
mkdir -p ~/arteflix && cd ~/arteflix
```

Drop your `Caddyfile` and `docker-compose.yml` there, log into `ghcr.io`, and start it:

```bash
docker compose pull
docker compose up -d
```

## Auto-deploy

The release workflow builds the image, pushes to `ghcr.io`, and SSHs into the VPS to pull + restart.

Needs these repo secrets: `VPS_HOST`, `VPS_USER`, `VPS_PORT`, `VPS_SSH_KEY`.

## Manual update

```bash
cd ~/arteflix
docker compose pull && docker compose up -d
```
