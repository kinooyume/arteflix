open StorybookMini

let default: meta<HeroContent.props> = {
  title: "Molecules/Hero/HeroContent",
  component: HeroContent.make,
}

let primary: storyObj<HeroContent.props> = {
  args: {
    title: "Les réfugiés de Saint-Jouin",
    subtitle: Some("Une famille syrienne en Normandie"),
    description: Some("Le maire d'une commune normande s'est porté volontaire pour accueillir des réfugiés. Un documentaire drolatique à la Tati."),
    href: "",
  },
}

let withCallToAction: storyObj<HeroContent.props> = {
  args: {
    title: "Les réfugiés de Saint-Jouin",
    subtitle: Some("Une famille syrienne en Normandie"),
    description: Some("Le maire d'une commune normande s'est porté volontaire pour accueillir des réfugiés. Un documentaire drolatique à la Tati."),
    href: "/fr/videos/123456-000-A/les-refugies",
    callToAction: Some("Lecture"),
  },
}
