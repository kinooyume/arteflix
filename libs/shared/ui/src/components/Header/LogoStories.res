open StorybookMini

let default: meta<HeaderLogo.props> = {
  title: "Atoms/Header/HeaderLogo",
  component: HeaderLogo.make,
}

let logo: storyObj<HeaderLogo.props> = {
  args: {
    homeHref: "#",
    alt: "Arteflix Logo",
    src: "../public/logo.png",
  },
}
