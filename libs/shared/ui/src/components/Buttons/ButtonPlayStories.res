open StorybookMini

let default: meta<ButtonPlay.props> = {
  title: "Atoms/Button/Button Play",
  component: ButtonPlay.make,
}

let primary: storyObj<ButtonPlay.props> = {
  args: {
    href: "",
    text: "Lecture"
  },
}

