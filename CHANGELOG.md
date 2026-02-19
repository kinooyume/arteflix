# Changelog
All notable changes to this project will be documented in this file. See [conventional commits](https://www.conventionalcommits.org/) for commit guidelines.

- - -
## v0.11.0 - 2026-02-19
#### Features
- (**deploy**) enable compression and static asset caching in Caddy - (49b7de4) - Martin Kinoo
- (**images**) migrate Arte images to next/image - (517657e) - Martin Kinoo
- (**preview**) increase hover scale to 1.5x - (629478c) - Martin Kinoo
#### Bug Fixes
- (**images**) eager load preview image to prevent flash - (9dfdc6c) - Martin Kinoo
- (**images**) use next/image in preview popup for cache sharing - (b471739) - Martin Kinoo
- (**preview**) dynamic sizing based on actual card width - (aba945f) - Martin Kinoo
- (**ui**) episode card image height with next/image - (1c34518) - Martin Kinoo
#### Performance Improvements
- (**api**) enable Next.js fetch cache on upstream Arte calls - (1a105a7) - Martin Kinoo
- (**images**) add sharp, explicit webp format and 30-day cache TTL - (e0466d9) - Martin Kinoo
- (**proxy**) add Cache-Control headers to API route handlers - (e66b37e) - Martin Kinoo
- (**swr**) disable revalidateOnFocus and bump deduping interval - (5581580) - Martin Kinoo
#### Miscellaneous Chores
- (**deploy**) locked-down deploy user with forced command - (06a4d1f) - Martin Kinoo

- - -

## v0.10.1 - 2026-02-19
#### Bug Fixes
- (**ui**) use valid arte CDN image sizes to prevent 404 on mobile - (eb8fcd2) - Martin Kinoo
- (**ux**) lower swipe threshold for mobile slider - (664f855) - Martin Kinoo

- - -

## v0.10.0 - 2026-02-18
#### Features
- (**ui**) live page, snappier hover cards + error handling - (953af8c) - Martin Kinoo
- (**ui**) responsive srcSet for hero, card + episode images - (30096fc) - Martin Kinoo
- (**ui**) shimmer skeleton, page skeleton + fade-in components - (95de680) - Martin Kinoo
- (**ui**) category codegen, nav dropdown + lang selector - (caf4314) - Martin Kinoo
- (**ux**) loading skeletons + fade-in page transitions - (0fe3595) - Martin Kinoo
#### Bug Fixes
- (**deploy**) cloudflare TLS + CI auto-deploy - (747767b) - Martin Kinoo
- (**ui**) exhaustive pattern matching in movie block cards - (4a51743) - Martin Kinoo
- (**ui**) netflix-like card density per viewport - (6da9d3c) - Martin Kinoo
- (**ui**) correct emotion keyframes binding - (0b3b1d2) - Martin Kinoo
- (**ui**) prevent hero text clipping on narrow viewports - (f5c7c39) - Martin Kinoo
- (**ui**) card slider gap + dropdown alignment - (d5e2a2e) - Martin Kinoo
- (**ui**) fluid responsive sizing across components - (fb7bd6a) - Martin Kinoo
- (**ui**) use flow-based hero image for full horizontal visibility - (4b8f2d2) - Martin Kinoo
- (**ui**) use fluid card sizing with fixed aspect ratio - (9dd9abf) - Martin Kinoo
#### Documentation
- add deploy guide - (5a40416) - Martin Kinoo

- - -

## v0.9.1 - 2026-02-17
#### Bug Fixes
- resolve merge conflict when syncing main into develop - (4330494) - Martin Kinoo
- unit test and ci  (#11) - (03d4419) - Martin Kinoo
- use standalone server for e2e tests - (5879177) - Martin Kinoo
- add minimal e2e smoke test - (a8dd62b) - Martin Kinoo
- remove broken scaffold e2e test - (06156ea) - Martin Kinoo
- remove broken scaffold test - (72192bd) - Martin Kinoo
#### Documentation
- update readme with badges, storybook section and CI details - (90f76c2) - Martin Kinoo
#### Miscellaneous Chores
- (**version**) v0.2.1 - (e273e35) - github-actions[bot]
- merge main into develop - (f07f075) - Martin Kinoo

- - -

## v0.2.1 - 2026-02-17
#### Bug Fixes
- unit test and ci  (#11) - (03d4419) - Martin Kinoo

- - -

## v0.2.0 - 2026-02-10
#### Bug Fixes
- run res:build before next build - (f6b2646) - Martin Kinoo
- nx project graph and broken imports - (f5abdc4) - Martin Kinoo
- exclude root from nx plugins - (c6ad77f) - Martin Kinoo
- unused variables in ZoneVideo - (2419f8e) - Martin Kinoo
#### Features
- initial release - (19b7782) - Martin Kinoo
#### Miscellaneous Chores
- **(version)** v0.2.0 - (23a98ef) - github-actions[bot]
- **(version)** v0.2.0 - (0eeae89) - github-actions[bot]
- **(version)** v0.2.0 - (5448de1) - github-actions[bot]
- **(version)** v0.2.0 - (9a5bffe) - github-actions[bot]

- - -

## v0.2.0 - 2026-02-10
#### Bug Fixes
- nx project graph and broken imports - (f5abdc4) - Martin Kinoo
- exclude root from nx plugins - (c6ad77f) - Martin Kinoo
- unused variables in ZoneVideo - (2419f8e) - Martin Kinoo
#### Features
- initial release - (19b7782) - Martin Kinoo
#### Miscellaneous Chores
- **(version)** v0.2.0 - (0eeae89) - github-actions[bot]
- **(version)** v0.2.0 - (5448de1) - github-actions[bot]
- **(version)** v0.2.0 - (9a5bffe) - github-actions[bot]

- - -

## v0.2.0 - 2026-02-10
#### Bug Fixes
- exclude root from nx plugins - (c6ad77f) - Martin Kinoo
- unused variables in ZoneVideo - (2419f8e) - Martin Kinoo
#### Features
- initial release - (19b7782) - Martin Kinoo
#### Miscellaneous Chores
- **(version)** v0.2.0 - (5448de1) - github-actions[bot]
- **(version)** v0.2.0 - (9a5bffe) - github-actions[bot]

- - -

## v0.2.0 - 2026-02-10
#### Bug Fixes
- unused variables in ZoneVideo - (2419f8e) - Martin Kinoo
#### Features
- initial release - (19b7782) - Martin Kinoo
#### Miscellaneous Chores
- **(version)** v0.2.0 - (9a5bffe) - github-actions[bot]

- - -

## v0.2.0 - 2026-02-10
#### Features
- initial release - (19b7782) - Martin Kinoo

- - -

Changelog generated by [cocogitto](https://github.com/cocogitto/cocogitto).