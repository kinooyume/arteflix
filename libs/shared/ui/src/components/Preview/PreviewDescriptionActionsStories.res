open StorybookMini

let default: meta<PreviewDescriptionActions.props> = {
  title: "Molecules/Preview/PreviewDescriptionActions",
  component: PreviewDescriptionActions.make,
}

let play: storyObj<PreviewDescriptionActions.props> = {
  args: {
    children: <PlayButtonRounded href="https://kinoo.dev" />,
  },
}
