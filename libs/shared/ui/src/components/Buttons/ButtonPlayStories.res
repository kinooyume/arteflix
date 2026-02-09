open StorybookMini

let default: meta<ButtonPlay.props> = {
  title: "Atoms/Buttons/ButtonPlay",
  component: ButtonPlay.make,
}

let primary: storyObj<ButtonPlay.props> = {
  args: {
    href: "",
    text: "Lecture"
  },
}

