# Arteflix

A Netflix-like interface for Arte.tv.

Built almost entirely in ReScript — this started as an experiment to see how far I could push ReScript in a real project with minimal JS/TS escape hatches. Turns out, pretty far.

## What's this?

Take any Arte URL, swap the domain with `arteflix.kinoo.dev`, and you get the same content with a cleaner UI. That's it.

Under the hood, I reverse engineered Arte's internal API to fetch all the content directly.

## Stack

- **ReScript** — the whole thing, basically
- **Next.js 15** + React 19
- **Emotion** for styles
- **SWR** for data fetching
- **Nx** monorepo (yeah, it's overkill for this, but I wanted to try it)
- **Bun** because npm is slow

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

```bash
# Dev
bun nx run arteflix:all:dev      # ReScript + Next.js in watch mode

# Build
bun nx run arteflix:all:build    # Full production build
bun nx run arteflix:start        # Run prod server

# Storybook
bun nx run ui:all:dev            # Component dev environment

# Tests
bun nx run arteflix:test         # Unit tests
bun nx run arteflix-e2e:e2e      # E2E with Playwright
```

## Project layout

```
apps/
  arteflix/         # the main app
  arteflix-e2e/     # e2e tests
libs/
  prefetch-arte/    # arte api stuff
  shared/ui/        # component library + storybook
```

## Deployment

The app builds as a standalone Next.js server and runs in Docker. Check the Dockerfile in `apps/arteflix/`.

## Known issues

- Nx doesn't play nice with `bun.lock` yet — https://github.com/nrwl/nx/issues/29494
- Some ReScript path resolution quirks with Nx, nothing major

## TODO

- TMDB integration for better metadata
- Offline support maybe?

## License

MIT
