open StorybookMini

let default: meta<EpisodeBlock.props> = {
  title: "Organisms/Episode/EpisodeBlock",
  component: EpisodeBlock.make,
}

let logo: storyObj<EpisodeBlock.props> = {
  args: {
    title: "The Newsreader",
    episodes: EpisodeListStories.logo.args.episodes,
  },
}
