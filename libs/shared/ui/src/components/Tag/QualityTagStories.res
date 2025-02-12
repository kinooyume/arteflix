open StorybookMini

let default: meta<QualityTag.props> = {
  title: "Atoms/Tags/QualityTag",
  component: QualityTag.make,
}

let logo: storyObj<QualityTag.props> = {
  args: {
    children: "HD",
  },
}
