open StorybookMini

let default: meta<PreviewDescriptionListText.props> = {
  title: "Atoms/Preview/PreviewDescriptionListText",
  component: PreviewDescriptionListText.make,
}

let hello: storyObj<PreviewDescriptionListText.props> = {
  args: {
    children: "Emotion",
  },
}

