open StorybookMini

let default: meta<CardOverlayTrailer.props> = {
  title: "Atoms/Cards/CardOverlayTrailer",
  component: CardOverlayTrailer.make,
}

let primary: storyObj<CardOverlayTrailer.props> = {
  args: {
    children: "Documentaires et reportages"->React.string
  },
}

