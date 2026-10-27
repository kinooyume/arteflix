open StorybookMini

let default: meta<MuteButton.props> = {
  title: "Atoms/Buttons/MuteButton",
  component: MuteButton.make,
}

let muted: storyObj<MuteButton.props> = {
  args: {
    muted: true,
    onToggle: () => (),
  },
}

let unmuted: storyObj<MuteButton.props> = {
  args: {
    muted: false,
    onToggle: () => (),
  },
}
