open StorybookMini

let default: meta<PreviewDescriptionActions.props> = {
  title: "Molecules/Lists/Preview Description Actions",
  component: PreviewDescriptionActions.make,
}

let play: storyObj<PreviewDescriptionActions.props> = {
  args: {
    children: <PlayButtonRounded href="https://kinoo.dev" />,
  },
}
