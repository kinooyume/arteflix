# Arteflix

A Netflix-style UI for [Arte.tv](https://arte.tv) content, built with ReScript and Next.js.

This project is an experiment to test ReScript's usability in a real-world application, aiming for minimal JavaScript/TypeScript usage while integrating modern tooling.

## Tech Stack

- **ReScript** (11.1.4) - Almost 100% of the codebase
- **Next.js 15** with React 19
- **SWR** for data fetching via [rescript-swr](https://github.com/rescriptbr/rescript-swr)
- **Emotion** for styling
- **Nx** for monorepo management
- **Bun** as package manager

### Testing

- Playwright (E2E)
- Storybook (Component development)
- Jest + React Testing Library (Unit tests)

## Installation

### Prerequisites

- [Bun](https://bun.sh) - Install with:
  ```bash
  curl -fsSL https://bun.sh/install | bash
  ```

### Setup

```bash
# Clone the repository
git clone https://github.com/your-username/arteflix.git
cd arteflix

# Install dependencies
bun install
```

## Usage

### Development

```bash
# Start development server (ReScript watch + Next.js)
bun nx run arteflix:all:dev

# Or run separately:
bun nx run arteflix:dev        # Next.js only
bun nx run arteflix:res:dev    # ReScript watch only
```

### Build

```bash
# Full build (ReScript + Next.js)
bun nx run arteflix:all:build

# Start production server
bun nx run arteflix:start
```

### Testing

```bash
# Unit tests
bun nx run arteflix:test

# E2E tests
bun nx run arteflix-e2e:e2e
```

### Storybook

```bash
# Development (ReScript watch + Storybook)
bun nx run ui:all:dev

# Or run separately:
bun nx run ui:storybook        # Storybook only
bun nx run ui:res:dev          # ReScript watch only

# Build static Storybook
bun nx run ui:all:build
```

### Linting

```bash
bun nx run arteflix:lint
```

## Project Structure

```
arteflix/
├── apps/
│   ├── arteflix/          # Main Next.js application
│   └── arteflix-e2e/      # Playwright E2E tests
└── libs/
    ├── prefetch-arte/     # Arte API data prefetching
    └── shared/            # Shared utilities
```

## Features

- All content from [arte.tv](https://arte.tv) available
- 1:1 URL compatibility - copy any URL from arte.tv and replace the domain with `arteflix.kinoo.dev`

### Planned

- TMDB integration for additional metadata

## Known Limitations

- Nx doesn't support the new `bun.lock` file yet ([GitHub issue](https://github.com/nrwl/nx/issues/29494))
- ReScript local file resolution has some quirks with Nx

## License

MIT
