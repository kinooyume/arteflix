open StorybookMini

let default: meta<EpisodeCard.props> = {
  title: "Atoms/Episode/Episode Card",
  component: EpisodeCard.make,
}

let logo: storyObj<EpisodeCard.props> = {
  args: {
      alt: "Arteflix Logo",
      src: "https://api-cdn.arte.tv/img/v2/image/AdNaCeYv8wePtPa2nfyvdW/265x149",
  },
}
