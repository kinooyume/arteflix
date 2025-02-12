open StorybookMini

let default: meta<MovieCardSticker.props> = {
  title: "Atoms/Card/CardSticker",
  component: MovieCardSticker.make,
}

let hello: storyObj<MovieCardSticker.props> = {
  args: {
    children: "Recently Added"->React.string
  },
}
