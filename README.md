# Arteflix

[![CI](https://github.com/kinooyume/arteflix/actions/workflows/ci.yml/badge.svg)](https://github.com/kinooyume/arteflix/actions/workflows/ci.yml)
[![Release](https://github.com/kinooyume/arteflix/actions/workflows/release.yml/badge.svg)](https://github.com/kinooyume/arteflix/actions/workflows/release.yml)


[![ReScript](https://img.shields.io/badge/ReScript-11-E84F4F?logo=rescript&logoColor=white)](https://rescript-lang.org)
[![Next.js](https://img.shields.io/badge/Next.js-15-000000?logo=next.js&logoColor=white)](https://nextjs.org)
[![React](https://img.shields.io/badge/React-19-61DAFB?logo=react&logoColor=white)](https://react.dev)
[![Bun](https://img.shields.io/badge/Bun-latest-FBF0DF?logo=bun&logoColor=black)](https://bun.sh)

A Netflix-like interface for Arte.tv.
Built almost entirely in ReScript — this started as an experiment to see how far I could push ReScript in a real project with minimal JS/TS escape hatches. Turns out, pretty far.


## What's this?

Take any Arte URL, swap the domain with `arteflix.kinoo.dev`, and you get the same content with a cleaner UI. That's it.

Under the hood, I reverse engineered Arte's internal API to fetch all the content directly.


## Getting started

You need [Bun](https://bun.sh):

```bash
curl -fsSL https://bun.sh/install | bash
```

Then:

```bash
bun install
bun nx run arteflix:all:dev
```

That's it. Open http://localhost:3000.


## Commands

| Command | Action |
|---------|--------|
| `bun nx run arteflix:all:dev` | Dev server (ReScript + Next.js in watch mode) |
| `bun nx run arteflix:all:build` | Full production build |
| `bun nx run arteflix:test` | Unit tests (Jest) |
| `bun nx run ui:test` | UI component tests |
| `bun nx run arteflix-e2e:e2e` | E2E tests (Playwright) |
| `bun nx run ui:storybook` | Storybook dev |
| `bun nx run arteflix:lint` | ESLint |


## Project layout

```
apps/
  arteflix/         # the main app
  arteflix-e2e/     # e2e tests
libs/
  prefetch-arte/    # arte api stuff
  shared/ui/        # component library + storybook
```


## Storybook

The UI library (`libs/shared/ui/`) has a full Storybook setup for developing components in isolation. All components are written in ReScript and have corresponding stories.

```bash
bun nx run ui:storybook
```

Components include cards, hero banners, episode lists, player, preview overlays, navigation, and tags — all the building blocks for the Netflix-style layout.


## CI/CD

```
feature/* → develop → main
              │         │
           CI tests   Release (Docker + GitHub Release)
```

Follows **Gitflow**: feature branches merge into `develop`, `develop` merges into `main` for releases.

- **feature → develop**: squash merge
- **develop → main**: merge commit

PRs to `develop` run build + unit tests + e2e. Pushing to `main` triggers a release: [cocogitto](https://docs.cocogitto.io/) bumps the version, generates a changelog, builds a Docker image, pushes it to `ghcr.io`, and creates a GitHub release. After that, `main` is merged back into `develop`.

Commits must follow [Conventional Commits](https://www.conventionalcommits.org):
```
feat(ui): add trailer overlay
fix: locale detection for polish
```

**Secrets needed**: `GITHUB_TOKEN` (automatic)


## Deployment

The app builds as a standalone Next.js server and runs in Docker. The production setup uses Caddy as a reverse proxy with automatic TLS. Check `apps/arteflix/Dockerfile` and `deploy/` for details.


## Stack

**Core**: ReScript, Next.js 15, React 19

**UI**: Emotion, Framer Motion, React Aria, Video.js, React Slick

**Data**: SWR, sury (schema validation)

**Dev**: Bun, Nx, Jest, Playwright, Storybook, Cocogitto


## Known issues

- Nx doesn't play nice with `bun.lock` yet — https://github.com/nrwl/nx/issues/29494
- Some ReScript path resolution quirks with Nx, nothing major


## TODO

- TMDB integration for better metadata
- Offline support maybe?


## License

MIT
