open StorybookMini

let default: meta<CardTrailer.props> = {
  title: "Molecules/Card/CardTrailer",
  component: CardTrailer.make,
}

let primary: storyObj<CardTrailer.props> = {
  args: {
    text: "Documentaires et reportages",
    children: <MovieCardImage {...MovieCardImageStories.horizontal.args} />,
  },
}
