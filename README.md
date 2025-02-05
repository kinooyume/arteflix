# Arteflix

> `Arte` content with `Netflix UI`
> Mainly based on this [Figma](https://figma.com) and reverse arte api.

I build this to test the usability of rescript in a real project with some **hot** stuffs and different techno that I'm not used to, and see how far I can go with the minimum of javascript/typescript as possible.

## Techno overview

- `Rescript` _11.1.4_, almost 100% except for some testing libs (playwright, react-testing-library)
- `React 19` and  `Next.js` \*\*
- Queries fetching through `swr` and [rescript-swr](https://github.com)

- `bun` and `nx`

- `docker`

<details>
  <summary>Style</summary>
 `emotions`
</details>

<details>
  <summary>Testing</summary>
  - `playwright`
  - `Storybook`
  - `React Testing Library`
  - `Jest`
</details>
### Testing

## Features

- all the content from [arte.tv](https://arte.tv) available.
- 1:1 url from [arte.tv](https://arte.tv), meaning you can copy an url from the official website and switch the domain name from `arte.tv` to `arteflix.kinoo.dev` 

### Plan features
- add tmdb support to fetch more information when possible

## Mono-repo

The  mono-repo is handler through `nx`, here is the list of the content:

> [!WARNING]
> Due to some current limitation with rescript, I had to tweak a bit as some features of `nx` are not well implemented. Maily: [xxxx],. However, it works well for this use case without issue.

<details>
  <summary>Current caveats</summary>
  - [ ] nx doesn't support the new `bun.lock` file yet. [Github issue](https://github.com/nrwl/nx/issues/29494) 
  - [ ] rescript local file doesn't work
</details>

### App

### Libraries

> All the libraries are :100: written in `rescript` :party: .

- `arte-api`, the result of my reverse engineering of the arte api.
- `netflix-ui`: the ui, inspired by this [figma](https://figma.com).
