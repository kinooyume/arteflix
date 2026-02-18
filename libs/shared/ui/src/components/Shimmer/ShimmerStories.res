open StorybookMini

let default: meta<Shimmer.props> = {
  title: "Atoms/Shimmer",
  component: Shimmer.make,
}

let card: storyObj<Shimmer.props> = {
  args: {
    width: "325px",
    height: "183px",
    borderRadius: "2px",
  },
}

let hero: storyObj<Shimmer.props> = {
  args: {
    width: "100%",
    height: "400px",
    borderRadius: "0px",
  },
}
