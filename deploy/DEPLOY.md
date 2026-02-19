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

On merge to `main`, the release workflow:

1. Bumps version + changelog (cocogitto)
2. Builds the Docker image and pushes it to `ghcr.io`
3. SSHs into the VPS to pull the new image and restart

The SSH key is locked down — it can only trigger a single deploy script on the server, nothing else. The deploy user has no shell, no docker access, and the key has `command=` forcing it to run the script via sudoers. Even if the key leaks, the worst that happens is an extra redeploy.

### Deploy script (`/usr/local/bin/arteflix-deploy`)

```bash
#!/bin/bash
cd /home/<user>/arteflix && docker compose pull && docker compose up -d
```

### Repo secrets needed

`VPS_HOST`, `VPS_USER`, `VPS_PORT`, `VPS_SSH_KEY`

## Manual update

```bash
cd ~/arteflix
docker compose pull && docker compose up -d
```
