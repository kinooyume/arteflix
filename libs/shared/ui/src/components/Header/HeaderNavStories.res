open StorybookMini

let default: meta<HeaderNav.props> = {
  title: "Molecules/Header/HeaderNav",
  component: HeaderNav.make,
}

let logo: storyObj<HeaderNav.props> = {
  args: {
    logo: {
      homeHref: "#",
      alt: "Arteflix Logo",
      src: "../public/logo.png",
    },
    links: [
      {
        text: "Concerts",
        href: "#",
      },
      {
        text: "Séries",
        href: "#",
      },
    ],
  },
}
