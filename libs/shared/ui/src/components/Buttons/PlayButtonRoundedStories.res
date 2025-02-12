open StorybookMini


let default: meta<PlayButtonRounded.props> = {

  title: "Atoms/Button/Play Button Rounded",
  component: PlayButtonRounded.make,
}

let hello: storyObj<PlayButtonRounded.props> = {
  args: {
    href: "https://www.arte.tv/fr/videos/093289-000-A/le-temps-des"
  },
}
