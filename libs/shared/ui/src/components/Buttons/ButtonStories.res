open StorybookMini

let default: meta<Button.props> = {
  title: "Atoms/Button",
  component: Button.make,
}

let primary: storyObj<Button.props> = {
  args: {
    variant: Button.Primary,
    size: Button.Medium,
    href: "",
    children: "play"->React.string,
  },
}

let secondary: storyObj<Button.props> = {
  args: {
    variant: Button.Secondary,
    size: Button.Medium,
    href: "",
    children: "play"->React.string,
  },
}

let tertiary: storyObj<Button.props> = {
  args: {
    variant: Button.Tertiary,
    size: Button.Medium,
    href: "",
    children: "play"->React.string,
  },
}
