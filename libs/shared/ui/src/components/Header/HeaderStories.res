open StorybookMini

let default: meta<Header.props> = {
  title: "Organisms/Header",
  component: Header.make,
}

let logo: storyObj<Header.props> = {
  args: {
    logo: {
      homeHref: "#",
      alt: "Arteflix Logo",
      src: "/logo.png",
    },
    links: [],
  },
}
