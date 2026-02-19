open StorybookMini

let default: meta<EpisodeBlock.props_> = {
  component: EpisodeBlock.make,
  title: "Organisms/EpisodeBlock",
}

let mockEpisodes: array<EpisodeButton.t> = [
  {
    id: "ep-1",
    href: "/en/videos/123456-001-A/episode-1",
    title: "The Beginning",
    description: Some("Our journey starts in the remote mountains of Nepal."),
    duration: Some("52 min"),
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/y4UHNRQxXcYAw5T8aprnDm/336x189",
    imageAlt: "Episode 1 thumbnail",
    selected: true,
  },
  {
    id: "ep-2",
    href: "/en/videos/123456-002-A/episode-2",
    title: "The Ascent",
    description: Some("The team faces their first major challenge."),
    duration: Some("48 min"),
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/y4UHNRQxXcYAw5T8aprnDm/336x189",
    imageAlt: "Episode 2 thumbnail",
    selected: false,
  },
  {
    id: "ep-3",
    href: "/en/videos/123456-003-A/episode-3",
    title: "The Storm",
    description: Some("A dangerous storm threatens the expedition."),
    duration: Some("55 min"),
    imageSrc: "https://api-cdn.arte.tv/img/v2/image/y4UHNRQxXcYAw5T8aprnDm/336x189",
    imageAlt: "Episode 3 thumbnail",
    selected: false,
  },
]

let withEpisodes: storyObj<EpisodeBlock.props_> = {
  args: {
    title: "The Last Mountain",
    episodes: mockEpisodes,
  },
}
