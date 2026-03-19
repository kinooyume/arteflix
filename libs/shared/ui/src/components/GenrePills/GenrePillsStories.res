open StorybookMini

let default: meta<GenrePills.props> = {
  title: "Molecules/GenrePills",
  component: GenrePills.make,
}

let basic: storyObj<GenrePills.props> = {
  args: {
    title: Some("Parcourir les genres"),
    items: [
      {title: "Cinéma", href: "/fr/videos/cinema/"},
      {title: "Séries", href: "/fr/videos/series-et-fictions/"},
      {title: "Documentaires", href: "/fr/videos/documentaires-et-reportages/"},
      {title: "Info et société", href: "/fr/videos/info-et-societe/"},
      {title: "Culture et pop", href: "/fr/videos/culture-et-pop/"},
      {title: "ARTE Concert", href: "/fr/videos/arte-concert/"},
    ],
  },
}

let withoutTitle: storyObj<GenrePills.props> = {
  args: {
    title: None,
    items: [
      {title: "Cinéma", href: "/fr/videos/cinema/"},
      {title: "Séries", href: "/fr/videos/series-et-fictions/"},
      {title: "Documentaires", href: "/fr/videos/documentaires-et-reportages/"},
    ],
  },
}
