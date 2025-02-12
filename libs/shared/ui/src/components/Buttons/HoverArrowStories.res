open StorybookMini

let default: meta<HoverArrow.props> = {
  title: "Atoms/Button/Hover Arrow",
  component: HoverArrow.make,
}

let logo: storyObj<HoverArrow.props> = {
  args: {
    text: "Voir tout",
    href: "#"
  },
}
