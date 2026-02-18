open StorybookMini

let default: meta<HeaderLangSelector.props<string, array<HeaderLangSelector.lang>>> = {
  title: "Molecules/Header/HeaderLangSelector",
  component: HeaderLangSelector.make,
}

let french: storyObj<HeaderLangSelector.props<string, array<HeaderLangSelector.lang>>> = {
  args: {
    current: "fr",
    langs: [
      {code: "fr", label: `Français`, href: "#"},
      {code: "de", label: "Deutsch", href: "#"},
      {code: "en", label: "English", href: "#"},
      {code: "es", label: `Español`, href: "#"},
      {code: "pl", label: "Polski", href: "#"},
      {code: "it", label: "Italiano", href: "#"},
    ],
  },
}
